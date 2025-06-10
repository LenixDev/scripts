import classNames from "classnames";
import { BottomLine } from "../BottomLine";
import "./index.sass";
import { whichColor } from "../../utils/misc";
import useData from "../../hooks/useData";
import { QueueProps } from "../../types/DataProviderTypes";
import useLocales from "../../hooks/useLocales";
import { useState } from "react";

export const CraftingQueue: React.FC = () => {
  const { themeColor, CraftingQueue, CompletedCraftingQueue, ItemPickUp } =
    useData();
  const { locale } = useLocales();
  const [loading, setLoading] = useState<boolean>(false);

  const handleItemPickUp = async (
    event: React.MouseEvent<HTMLButtonElement, MouseEvent>,
    _queue: QueueProps
  ) => {
    event?.preventDefault();
    if (!loading) {
      event.currentTarget.disabled = true;
      setLoading(true);
      const itsOkey = await ItemPickUp(_queue);
      if (itsOkey) {
        setLoading(false);
      }
    }
  };

  const JSX_Queue = (index: number, queue: QueueProps, c: boolean) => {
    if (!queue) return <></>;
    return (
      <div className="w-[312px] h-[122px]" key={index}>
        <div className="flex h-full w-full">
          <div className="h-full w-6 bg-[#444] rounded-l flex items-center justify-center">
            <svg
              width="9"
              height="18"
              viewBox="0 0 9 18"
              fill="none"
              xmlns="http://www.w3.org/2000/svg"
              className={classNames("fill-[#222222]")}
            >
              <path
                id="Vector"
                d="M0.0521748 16.9557C0.00855103 17.0703 -0.00809978 17.1944 0.00366719 17.3174C0.0154342 17.4404 0.055263 17.5584 0.119698 17.6613C0.184132 17.7642 0.271225 17.8489 0.373417 17.9079C0.475608 17.9669 0.58981 17.9985 0.706109 18H5.35155C5.35012 17.8862 5.37207 17.7735 5.41587 17.6696L9 9L5.42659 0.330378C5.37909 0.227427 5.35347 0.114641 5.35155 0H0.706109C0.592023 0.00262642 0.480187 0.0342484 0.379956 0.0922165C0.279725 0.150187 0.194014 0.232817 0.12999 0.3332C0.0659669 0.433582 0.0254938 0.5488 0.0119558 0.66921C-0.0015822 0.789623 0.0122085 0.91173 0.0521748 1.02532L3.33972 9L0.0521748 16.9557Z"
              />
            </svg>
          </div>
          <div className="w-full flex flex-row justify-between p-2 _bg_i_c">
            <div className="flex flex-col gap-1.5 justify-between items-start">
              <div className="font-Akira text-[#444] overflow-auto max-w-40 no-scrollbar brightness-150">
                <div>
                  <h1 className="text-sm">{queue?.label}</h1>
                </div>
                <h1 className="text-[10px]">{locale.text_crafting}</h1>
              </div>
              <div>
                <div className="mb-2">
                  <div className="w-[100px] h-1.5 bg-[#444] relative">
                    <div
                      className={classNames(
                        "h-1.5 absolute left-0 max-w-[100px]",
                        whichColor(themeColor, "background")
                      )}
                      style={{
                        width:
                          queue.remaining !== undefined
                            ? queue.remaining >= 0
                              ? ((queue.duration - queue.remaining) /
                                  queue.duration) *
                                  100 +
                                "%"
                              : "100%"
                            : "%0",
                      }}
                    ></div>
                  </div>
                </div>
                <div>
                  <button
                    className={classNames(
                      "w-[100px] h-7 border",
                      whichColor(themeColor, "background-linear"),
                      whichColor(themeColor, "border")
                    )}
                    disabled={
                      !c ||
                      loading ||
                      queue.remaining === undefined ||
                      queue.remaining > 0
                    }
                    onClick={(e) => c && handleItemPickUp(e, queue)}
                  >
                    <span className="font-Akira text-sm text-white">
                      {queue.remaining !== undefined
                        ? queue.remaining > 0 || !c
                          ? new Date(queue.remaining).toLocaleTimeString(
                              "en-US",
                              {
                                minute: "2-digit",
                                second: "2-digit",
                              }
                            )
                          : locale.text_pick_up
                        : new Date(queue.duration).toLocaleTimeString("en-US", {
                            minute: "2-digit",
                            second: "2-digit",
                          })}
                    </span>
                  </button>
                </div>
              </div>
            </div>
            <div className="bg-queueitem flex items-center justify-center max-h-32 max-w-32 w-full h-full border border-[#444444]">
              <img
                className="max-w-24 max-h-24"
                src={"images/" + queue.image}
                alt={queue.name}
              />
            </div>
          </div>
        </div>
      </div>
    );
  };

  return (
    <div className="my-4 max-h-[532px]">
      <div className="w-full h-full overflow-auto volta ltr flex flex-col gap-3">
        {CompletedCraftingQueue.map((queue, index) =>
          JSX_Queue(index, queue, true)
        )}
        {CraftingQueue.map((queue, index) => JSX_Queue(index, queue, false))}
      </div>
      <BottomLine direction="rtl" />
    </div>
  );
};
