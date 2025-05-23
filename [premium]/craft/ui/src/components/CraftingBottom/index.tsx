import classNames from "classnames";
import useData from "../../hooks/useData";
import { whichColor } from "../../utils/misc";
import { HR } from "../HR";
import useLocales from "../../hooks/useLocales";
import { useState } from "react";

export const CraftingBottom = () => {
  const { themeColor, selectedCraftableItem, AddSelectedItemToCraftingQueue } =
    useData();
  const { locale } = useLocales();
  const [loading, setLoading] = useState<boolean>(false);

  const handleCraftNewItem = async (
    event: React.MouseEvent<HTMLButtonElement>
  ) => {
    event.preventDefault();
    if (!loading) {
      setLoading(true);
      const itsOkey = await AddSelectedItemToCraftingQueue();
      if (itsOkey) {
        setTimeout(() => {
          setLoading(false);
        }, 1000);
      }
    }
  };

  return (
    <>
      <div className="w-full text-center flex justify-between items-center gap-8 mb-8">
        <HR />
        <div className="relative">
          <button
            className="relative group"
            disabled={!selectedCraftableItem.canItBeCraftable || loading}
            onClick={handleCraftNewItem}
          >
            <div
              className={classNames(
                "absolute w-2 h-11 -left-[7.7px] half-hexagon",
                whichColor("_181818", "background"),
                {
                  "group-hover:!bg-white":
                    selectedCraftableItem.canItBeCraftable,
                }
              )}
            />
            <h1
              className={classNames(
                "font-Akira whitespace-nowrap h-11 border-2 py-2 flex items-center px-3 text-gray-400",
                whichColor("_181818", "border"),
                "bg-black/60",
                {
                  "line-through": !selectedCraftableItem.canItBeCraftable,
                  "group-hover:!text-white group-hover:!border-white":
                    selectedCraftableItem.canItBeCraftable,
                }
              )}
            >
              {locale.text_start_crafting}
            </h1>
            <div
              className={classNames(
                "absolute w-2 h-11 bottom-0 -right-[7.7px] half-hexagon rotate-180",
                whichColor("_181818", "background"),
                {
                  "group-hover:!bg-white":
                    selectedCraftableItem.canItBeCraftable,
                }
              )}
            />
          </button>
        </div>
        <HR />
        <div
          className={classNames(
            "absolute bottom-0 -left-12 w-2/5 shadow-[0_0_200px_15px] rotate-6",
            whichColor(themeColor, "shadow")
          )}
        />
        <div
          className={classNames(
            "absolute bottom-0 -right-12 w-2/5 shadow-[0_0_200px_15px] -rotate-6",
            whichColor(themeColor, "shadow")
          )}
        />
      </div>
    </>
  );
};
