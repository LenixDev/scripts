import classNames from "classnames";
import { whichColor } from "../../../utils/misc";
import useData from "../../../hooks/useData";
import { BottomLine } from "../../BottomLine";
import { WeaponProps } from "../../../types/DataProviderTypes";
import useLocales from "../../../hooks/useLocales";

export const InventoryGun = () => {
  const { themeColor, inventoryWeapons, selectedItem, loadSelectedWeapon } =
    useData();
  const { locale } = useLocales();

  const handleSelectNewWeapon = (item: WeaponProps) => {
    loadSelectedWeapon(item);
  };

  return (
    <>
      <div>
        <div className="flex flex-col gap-3 max-h-[70vh] volta">
          {inventoryWeapons.map((item, index) => (
            <div
              className={classNames("w-[170px] shrink-0 cursor-pointer group")}
              onClick={() => {
                handleSelectNewWeapon(item);
              }}
              key={index}
            >
              <div className="group-hover:brightness-150">
                <div
                  className={classNames(
                    "h-[190px] w-full bg-444-linear flex flex-col p-2 border border-[#444]",
                    selectedItem?.index == item?.index &&
                      whichColor(themeColor, "border")
                  )}
                >
                  <div className="m-auto">
                    <img
                      src={`images/weapons/${item?.image}`}
                      alt="weapon-img"
                    />
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
                            selectedItem?.index == item?.index &&
                              whichColor(themeColor, "background")
                          )}
                        >
                          {item?.attachments[acc_index]?.image && (
                            <img
                              className="w-full h-full"
                              src={
                                "images/weapons/" +
                                item?.attachments[acc_index]?.image
                              }
                              alt={"component_img_" + acc_index}
                            />
                          )}
                        </div>
                      ))}
                    </div>
                    <div
                      className={classNames(
                        "text-start text-[#444] flex items-center",
                        selectedItem?.index == item?.index &&
                          whichColor(themeColor, "text")
                      )}
                    >
                      <svg
                        className="mr-1"
                        width="20"
                        height="19"
                        viewBox="0 0 20 19"
                        fill="none"
                        xmlns="http://www.w3.org/2000/svg"
                      >
                        <g id="Group 43">
                          <path
                            className={classNames(
                              "fill-[#444444]",
                              selectedItem?.index == item?.index &&
                                whichColor(themeColor, "fill")
                            )}
                            id="Vector 25"
                            d="M6.04545 0L0 19H3L9.04545 0H6.04545Z"
                          />
                          <path
                            className={classNames(
                              "fill-[#444444]",
                              selectedItem?.index == item?.index &&
                                whichColor(themeColor, "fill")
                            )}
                            id="Vector 26"
                            d="M11.0455 0L5 19H8L14.0455 0H11.0455Z"
                          />
                          <path
                            className={classNames(
                              "fill-[#444444]",
                              selectedItem?.index == item?.index &&
                                whichColor(themeColor, "fill")
                            )}
                            id="Vector 27"
                            d="M16.0455 0L10 19H13L19.0455 0H16.0455Z"
                          />
                        </g>
                      </svg>
                      <span className="font-extrabold font-Akira text-[9px] tracking-widest">
                        {item?.label}
                      </span>
                    </div>
                  </div>
                </div>
              </div>
              <div
                className={classNames(
                  "bg-[#444] rounded-b p-1.5",
                  selectedItem?.index == item?.index &&
                    whichColor(themeColor, "background")
                )}
              >
                <h1
                  className={classNames(
                    "font-Akira text-center text-[#181818] text-sm",
                    selectedItem?.index == item?.index && "!text-white"
                  )}
                >
                  {locale.text_modify}
                </h1>
              </div>
            </div>
          ))}
        </div>
        <BottomLine />
      </div>
    </>
  );
};
