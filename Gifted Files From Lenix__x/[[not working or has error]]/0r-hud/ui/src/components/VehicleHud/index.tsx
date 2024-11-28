import { MdElectricBolt } from "react-icons/md";
import useData from "../../hooks/useData";
import classNames from "classnames";
import "./index.sass";

export const VehicleHud = () => {
  const { vehicleHud } = useData();
  const iRpm = 18;

  return (
    <>
      {!vehicleHud?.hidden && vehicleHud?.show && !vehicleHud.isPassenger && (
        <>
          <div className="flex justify-between">
            <div>
              <div className="flex flex-col gap-1">
                <div className="flex gap-2.5 mb-1">
                  <div hidden={vehicleHud?.isSeatbeltOn}>
                    <div className="animate-pulse">
                      <img
                        className="w-6 h-6"
                        src="images/seat-belt.svg"
                        alt="seat-belt"
                      />
                    </div>
                  </div>
                  <div hidden={vehicleHud?.engineHealth > 300}>
                    <div>
                      <img
                        src="images/engine-health.svg"
                        alt="engine-health"
                        className="w-6 h-6 animate-pulse"
                      />
                    </div>
                  </div>
                  <div hidden={!vehicleHud?.lightsOn}>
                    <div>
                      <img
                        src="images/light.svg"
                        alt="vehicle-light"
                        className="w-6 h-6"
                      />
                    </div>
                  </div>
                </div>
                {vehicleHud.type == 1 && (
                  <div className="my-1 -mt-0.5">
                    <div className="flex items-center">
                      <div className="-ml-[3px]">
                        {vehicleHud?.fuel?.type == "gasoline" && (
                          <img
                            src="images/fuel.svg"
                            alt="fuel_svg"
                            className="text-white w-7 h-7 relative"
                          />
                        )}
                        {vehicleHud?.fuel?.type == "electric" && (
                          <MdElectricBolt className="text-white w-6 h-6 relative" />
                        )}
                      </div>
                      <div className="w-full">
                        <div className="w-full h-[0.5rem] bg-gray-700/10 flex">
                          <div
                            className="bg-white"
                            style={{ width: vehicleHud?.fuel?.level + "%" }}
                          ></div>
                        </div>
                      </div>
                    </div>
                  </div>
                )}
                <div>
                  <div className="flex items-center justify-between gap-1 -mb-1">
                    <div className="h-[56px] mb-1 py-1 px-2 border border-[#C4FF48] bg-[#C4FF48] shadow-[#C4FF48] shadow-[0px_0px_4px_0px]">
                      <div className="items-center font-medium text-base">
                        <h1 className="text-[#272727] font-bold text-center text-lg">
                          {vehicleHud?.gear}
                        </h1>
                        <img
                          src="images/gear.svg"
                          alt="gear"
                          className="w-4 h-4 mb-1"
                        />
                      </div>
                    </div>
                    <div className="h-[56px] bg-black/40 rounded-sm mb-1 px-2 py-1 relative">
                      <div className="absolute right-0.5 top-0">
                        <h1 className="text-white/60 text-[9px] font-semibold font-[inherit] float-right">
                          {vehicleHud?.kmH ? "KMH" : "MPH"}
                        </h1>
                      </div>
                      <h1
                        className={`text-5xl tracking-wider speed ${
                          vehicleHud?.speed === 0
                            ? "text-white/60"
                            : "text-white"
                        }`}
                      >
                        {Array.from(
                          (vehicleHud?.speed || 0).toString().padStart(3, "0")
                        ).map((digit, index) => (
                          <span
                            key={index}
                            className={
                              vehicleHud?.speed === 0
                                ? "text-white/60"
                                : index <
                                  3 - vehicleHud?.speed?.toString().length
                                ? "text-white/60"
                                : ""
                            }
                          >
                            {digit}
                          </span>
                        ))}
                      </h1>
                    </div>
                  </div>
                </div>
                <div className="mt-1 relative">
                  {vehicleHud.type == 1 && (
                    <>
                      <ul className="flex justify-between">
                        {[...Array(iRpm)].map((_, i) => (
                          <li
                            key={i}
                            className={classNames(
                              "w-1 h-6 bg-[#2a2f30] transition-[color,transform_.5s] duration-200",
                              {
                                "!bg-[#C4FF48] shadow-[#C4FF48] shadow-[0px_0px_2px_0px] animate-rpm":
                                  i < 14 && i < Math.round(vehicleHud.rpm * 18),
                              },
                              {
                                "!bg-[#FFC148] shadow-[#FFC148] shadow-[0px_0px_2px_0px] animate-rpm":
                                  i >= 14 &&
                                  i < 16 &&
                                  i < Math.round(vehicleHud.rpm * 18),
                              },
                              {
                                "!bg-[#FF9548] shadow-[#FF9548] shadow-[0px_0px_2px_0px] animate-rpm":
                                  i >= 15 &&
                                  i < 16 &&
                                  i < Math.round(vehicleHud.rpm * 18),
                              },
                              {
                                "!bg-[#FF4848] shadow-[#FF4848] shadow-[0px_0px_2px_0px] animate-rpm animate-rpmbounce":
                                  i >= 16 &&
                                  i < Math.round(vehicleHud.rpm * 18),
                              },
                              {
                                "delay-500":
                                  i == 18 &&
                                  i <= Math.round(vehicleHud.rpm * 18),
                              }
                            )}
                          />
                        ))}
                      </ul>
                    </>
                  )}
                  {vehicleHud.type == 2 && (
                    <>
                      <div className="absolute top-0 -left-[2p4]">
                        <div
                          className={classNames("rpm-last-element-left", {
                            "!bg-[#C4FF48]":
                              Math.round(vehicleHud.rpm * 15) > 1,
                          })}
                        ></div>
                      </div>
                      <svg
                        xmlns="http://www.w3.org/2000/svg"
                        width="144"
                        height="22"
                        viewBox="0 0 144 22"
                        fill="none"
                      >
                        <path
                          d="M14.5 0H21.5L7 22H0L14.5 0Z"
                          className={classNames("fill-black/40", {
                            "!fill-[#C4FF48]":
                              Math.round(vehicleHud.rpm * 15) >= 2,
                          })}
                        />
                        <path
                          d="M24.5 0H31.5L17 22H10L24.5 0Z"
                          className={classNames("fill-black/40", {
                            "!fill-[#C4FF48]":
                              Math.round(vehicleHud.rpm * 15) >= 3,
                          })}
                        />
                        <path
                          d="M34.5 0H41.5L27 22H20L34.5 0Z"
                          className={classNames("fill-black/40", {
                            "!fill-[#C4FF48]":
                              Math.round(vehicleHud.rpm * 15) >= 4,
                          })}
                        />
                        <path
                          d="M44.5 0H51.5L37 22H30L44.5 0Z"
                          className={classNames("fill-black/40", {
                            "!fill-[#C4FF48]":
                              Math.round(vehicleHud.rpm * 15) >= 5,
                          })}
                        />
                        <path
                          d="M54.5 0H61.5L47 22H40L54.5 0Z"
                          className={classNames("fill-black/40", {
                            "!fill-[#C4FF48]":
                              Math.round(vehicleHud.rpm * 15) >= 6,
                          })}
                        />
                        <path
                          d="M65 0H72L57.5 22H50.5L65 0Z"
                          className={classNames("fill-black/40", {
                            "!fill-[#FFC148]":
                              Math.round(vehicleHud.rpm * 15) >= 7,
                          })}
                        />
                        <path
                          d="M75.5 0H82.5L68 22H61L75.5 0Z"
                          className={classNames("fill-black/40", {
                            "!fill-[#FFC148]":
                              Math.round(vehicleHud.rpm * 15) >= 8,
                          })}
                        />
                        <path
                          d="M85.5 0H92.5L78 22H71L85.5 0Z"
                          className={classNames("fill-black/40", {
                            "!fill-[#FF9548]":
                              Math.round(vehicleHud.rpm * 15) >= 9,
                          })}
                        />
                        <path
                          d="M95.5 0H102.5L88 22H81L95.5 0Z"
                          className={classNames("fill-black/40", {
                            "!fill-[#FF9548]":
                              Math.round(vehicleHud.rpm * 15) >= 10,
                          })}
                        />
                        <path
                          d="M106 0H113L98.5 22H91.5L106 0Z"
                          className={classNames("fill-black/40", {
                            "!fill-[#FF6948]":
                              Math.round(vehicleHud.rpm * 15) >= 11,
                          })}
                        />
                        <path
                          d="M116.5 0H123.5L109 22H102L116.5 0Z"
                          className={classNames("fill-black/40", {
                            "!fill-[#FF6948]":
                              Math.round(vehicleHud.rpm * 15) >= 12,
                          })}
                        />
                        <path
                          d="M126.5 0H133.5L119 22H112L126.5 0Z"
                          className={classNames("fill-black/40", {
                            "!fill-[#FF4848]":
                              Math.round(vehicleHud.rpm * 15) >= 13,
                          })}
                        />
                        <path
                          d="M136.5 0H143.5L129 22H122L136.5 0Z"
                          className={classNames("fill-black/40", {
                            "!fill-[#FF4848]":
                              Math.round(vehicleHud.rpm * 15) >= 14,
                          })}
                        />
                      </svg>
                      <div className="absolute bottom-0 right-[3px]">
                        <div
                          className={classNames("rpm-last-element-right", {
                            "!bg-[#ff3030]":
                              Math.round(vehicleHud.rpm * 15) >= 15,
                          })}
                        ></div>
                      </div>
                    </>
                  )}
                  {vehicleHud.type == 3 && (
                    <>
                      <div className="w-full bg-gradient-to-r from-[#C4FF48] to-[#FF4848] h-6 flex flex-row-reverse">
                        <div
                          className="bg-black/90 h-6"
                          style={{
                            width: (1 - vehicleHud.rpm) * 100 + "%",
                          }}
                        />
                      </div>
                    </>
                  )}
                </div>
              </div>
            </div>
            {(vehicleHud.type == 2 || vehicleHud.type == 3) && (
              <div>
                <div className="flex flex-col items-center h-full gap-1 ml-1">
                  <div>
                    {vehicleHud?.fuel?.type == "gasoline" && (
                      <img
                        src="images/fuel.svg"
                        alt="fuel_svg"
                        className="text-white w-6 h-6 relative"
                      />
                    )}
                    {vehicleHud?.fuel?.type == "electric" && (
                      <MdElectricBolt className="text-white w-4 h-4 relative" />
                    )}
                  </div>
                  <div className="h-full">
                    <div className="w-2 h-full bg-gray-700/10 flex flex-col-reverse">
                      <div
                        className="bg-white w-2"
                        style={{ height: vehicleHud?.fuel?.level + "%" }}
                      ></div>
                    </div>
                  </div>
                </div>
              </div>
            )}
          </div>
        </>
      )}
    </>
  );
};
