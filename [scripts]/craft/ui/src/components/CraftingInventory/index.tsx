import classNames from "classnames";
import { BottomLine } from "../BottomLine";
import useData from "../../hooks/useData";
import {
  CraftableItemProps,
  IngredientsProps,
} from "../../types/DataProviderTypes";
import { whichColor } from "../../utils/misc";
import useLocales from "../../hooks/useLocales";

export const CraftingInventory: React.FC = () => {
  const {
    CraftableItems,
    themeColor,
    selectedCraftableItem,
    loadSelectedCraftableItem,
  } = useData();
  const { locale } = useLocales();

  const handleSelectCraftableItem = (item: CraftableItemProps) => {
    loadSelectedCraftableItem(item);
  };

  const ingredientItemImage = (
    index: number,
    ingredients: IngredientsProps
  ): React.ReactNode => {
    const entries = Object.entries(ingredients);
    if (!entries[index]) {
      return <></>;
    }
    const [key, ,] = entries[index];
    const imagePath = key.toLowerCase().includes("weapon_")
      ? "images/weapons/"
      : "images/items/";
    const imageName = key.toLowerCase() + ".png";
    return (
      <img key={key} src={`${imagePath}${imageName}`} alt={`${key} image`} />
    );
  };

  return (
    <div className="mt-4">
      <div className="flex flex-col gap-3 max-h-[70vh] volta">
        {CraftableItems.map((item, index) => (
          <div
            className={classNames("w-[170px] shrink-0 cursor-pointer group")}
            onClick={() => {
              handleSelectCraftableItem(item);
            }}
            key={index}
          >
            <div className="group-hover:brightness-150">
              <div
                className={classNames(
                  "h-[190px] w-full bg-444-linear flex flex-col p-2 border border-[#444]",
                  {
                    [whichColor(themeColor, "border")]:
                      selectedCraftableItem.name == item.name,
                  }
                )}
              >
                <div className="m-auto max-h-32 max-w-32">
                  <img src={`images/${item?.image}`} alt="craftable-item-img" />
                </div>
                <div className="mt-auto">
                  <div
                    className={classNames(
                      "flex items-center mt-auto mb-2 gap-1 justify-between"
                    )}
                  >
                    {Array.from({ length: 6 }, (_, acc_index) => (
                      <div
                        key={acc_index}
                        className={classNames(
                          "w-6 h-6 bg-[#444] rounded-sm flex items-center justify-center p-[1px]",
                          {
                            [whichColor(themeColor, "background")]:
                              selectedCraftableItem.name == item.name,
                          }
                        )}
                      >
                        {ingredientItemImage(acc_index, item.ingredients)}
                      </div>
                    ))}
                  </div>
                  <div
                    className={classNames(
                      "text-start text-[#444] flex items-center",
                      {
                        [whichColor(themeColor, "text")]:
                          selectedCraftableItem.name == item.name,
                      }
                    )}
                  >
                    <svg
                      className={classNames("mr-1 max-w-5 max-h-5 w-full")}
                      viewBox="0 0 20 19"
                      fill="none"
                      xmlns="http://www.w3.org/2000/svg"
                    >
                      <g id="Group 43">
                        <path
                          className={classNames("fill-[#444444]", {
                            [whichColor(themeColor, "fill")]:
                              selectedCraftableItem.name == item.name,
                          })}
                          id="Vector 25"
                          d="M6.04545 0L0 19H3L9.04545 0H6.04545Z"
                        />
                        <path
                          className={classNames("fill-[#444444]", {
                            [whichColor(themeColor, "fill")]:
                              selectedCraftableItem.name == item.name,
                          })}
                          id="Vector 26"
                          d="M11.0455 0L5 19H8L14.0455 0H11.0455Z"
                        />
                        <path
                          className={classNames("fill-[#444444]", {
                            [whichColor(themeColor, "fill")]:
                              selectedCraftableItem.name == item.name,
                          })}
                          id="Vector 27"
                          d="M16.0455 0L10 19H13L19.0455 0H16.0455Z"
                        />
                      </g>
                    </svg>
                    <div
                      className={classNames(
                        "overflow-auto whitespace-nowrap no-scrollbar"
                      )}
                    >
                      <h1 className="font-extrabold font-Akira text-[10px] tracking-widest">
                        {item?.label}
                      </h1>
                      {item?.count > 1 && (
                        <h1 className="font-Akira text-[9px]">
                          {item?.count}x
                        </h1>
                      )}
                      <div
                        className={classNames(
                          "flex items-center justify-start gap-1",
                          {
                            "brightness-150":
                              selectedCraftableItem.name == item.name,
                          }
                        )}
                      >
                        <h1
                          className={classNames(
                            "font-extrabold font-Akira text-[10px] tracking-widest text-[#999999]"
                          )}
                        >
                          $
                        </h1>
                        <h1
                          className={classNames(
                            "font-extrabold font-Akira text-[10px] tracking-widest text-[#999999]"
                          )}
                        >
                          {item?.price}
                        </h1>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div
              className={classNames("bg-[#444] rounded-b p-1.5", {
                [whichColor(themeColor, "background")]:
                  selectedCraftableItem.name == item.name,
              })}
            >
              <h1
                className={classNames(
                  "font-Akira text-center text-[#181818] text-sm",
                  {
                    "!text-white": selectedCraftableItem.name == item.name,
                  }
                )}
              >
                {locale.text_craft}
              </h1>
            </div>
          </div>
        ))}
      </div>
      <BottomLine />
    </div>
  );
};
