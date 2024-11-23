const Functions = new Map();
const NewPromiseZz = new Map();
const Resource = GetCurrentResourceName();
let CallIdentifier = 0;

function TriggerNetClientEvent(src, pEvent, ...params) {
    const payload = msgpack_pack(params);
    if (payload.length < 5000) {
        TriggerClientEventInternal(pEvent, src, payload, payload.length);
    } else {
        TriggerLatentClientEventInternal(pEvent, src, payload, payload.length, 128000);
    }
}

function ParamUnpacker(params) {
    const pack = []
    return params.forEach(idx => pack.push(idx["param"])), pack
}

function ParamPacker(...params) {
    const pack = [];

    for (let i = 0; i < params.length; i += 1) {
        pack[i] = {
            "param": params[i]
        }
    }

    return pack
}

function rpcRegister(name, func) {
    Functions.set(name, func)
}

async function rpcExecute(name, ...params) {
    let src = source
    const callID = CallIdentifier
    CallIdentifier++

    const Call = new Promise((resolve, reject) => {
        NewPromiseZz.set(callID, {
            "resolve": resolve,
            "reject": reject,
        })
    })

    // TriggerNetClientEvent("nopixel:rpc:request", params[0], Resource, name, callID, params, false)
    emitNet("nopixel:rpc:request", params[0], Resource, name, callID, params, false)

    const clearPromise = new Promise((resolve) => {
        setTimeout(() => {
            if (NewPromiseZz.has(callID)) {
                NewPromiseZz.delete(callID)
            }
            return resolve([])
        }, 20000)
    })

    return await Promise.race([Call, clearPromise])
}

RegisterServerEvent("nopixel:rpc:request")
on('nopixel:rpc:request', async (origin, name, callID, params, boolean) => {
    const src = source
    if (boolean == true) {
        return
    }

    // console.log("RPC.JS", origin, name, callID, params, boolean)

    //const [a, b, c, d, e, f, g, h, j, k, l, m, n] = params;

    if (!Functions.has(name)) {
        return
    }

    const selectFunc = Functions.get(name);
    let response;

    try {
        response = await selectFunc(...params)
    } catch (error) {
        emit("rpc:client:error", Resource, origin, name, error["message"])
    }

    if (typeof response === "undefined") {
        response = [];
    }

    // TriggerNetClientEvent("nopixel:rpc:response", src, origin, callID, response, boolean);
    emitNet("nopixel:rpc:response", src, origin, callID, response, boolean);
})

RegisterServerEvent("nopixel:rpc:response")
on('nopixel:rpc:response', async (pOrigin, pCallId, pResponse, pPacked) => {
    if (Resource === pOrigin && NewPromiseZz.has(pCallId)) {
        if (pPacked) {
            pResponse = ParamUnpacker(pResponse);
        }
        NewPromiseZz.get(pCallId).resolve(pResponse);
        NewPromiseZz.delete(pCallId);
    }
})

const RPC = {
    "register": rpcRegister,
    "execute": rpcExecute,
}

