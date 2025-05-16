import classNames from "classnames";
import useData from "../../hooks/useData";
import { whichColor } from "../../utils/misc";
import useLocales from "../../hooks/useLocales";

export const CraftingTopRight: React.FC = () => {
  const { themeColor } = useData();
  const { locale } = useLocales();

  const getStarIcon = (): string => {
    switch (themeColor) {
      case "_green":
        return "images/green_sbag.svg";
      case "_orange":
        return "images/orange_sbag.svg";
      case "_red":
        return "images/red_sbag.svg";
      case "_blue":
        return "images/blue_sbag.svg";
      default:
        return "images/orange_sbag.svg";
    }
  };

  return (
    <>
      <div className="flex items-center justify-end gap-3">
        <div>
          <h1
            className={classNames(
              "mb-0.5 uppercase text-xl font-Akira text-end",
              whichColor(themeColor, "text")
            )}
          >
            {locale.text_crafting_queue}
          </h1>
          <h1 className="whitespace-pre-wrap text-[#9E9E9E] text-[9px] uppercase font-Akira text-end">
            {locale.text_items_queued}
          </h1>
        </div>
        <div>
          <img
            className={classNames(
              "shrink-0",
              whichColor(themeColor, "text"),
              whichColor(themeColor, "drop-shadow")
            )}
            src={getStarIcon()}
            alt="theme_sbag_icon"
          />
        </div>
      </div>
    </>
  );
};
