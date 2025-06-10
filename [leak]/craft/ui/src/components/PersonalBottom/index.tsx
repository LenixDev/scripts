import classNames from "classnames";
import useData from "../../hooks/useData";
import { whichColor } from "../../utils/misc";
import useLocales from "../../hooks/useLocales";

export const PersonalBottom = () => {
  const { themeColor, selectedItem } = useData();
  const { locale } = useLocales();

  return (
    <>
      <div className="w-full text-center flex justify-center items-center mb-2">
        <div className="relative z-10">
          <h1
            className={classNames(
              "text-xl font-Akira tracking-wider whitespace-nowrap",
              whichColor(themeColor, "text")
            )}
          >
            {selectedItem?.label ?? locale.text_choose_an_item}
          </h1>
          <h1
            hidden={!selectedItem?.name}
            className={classNames(
              "font-Akira tracking-wider whitespace-nowrap text-xs text-white/80"
            )}
          >
            {locale.text_modify} {selectedItem?.label}
          </h1>
        </div>
        <div
          className={classNames(
            "absolute bottom-0 w-1/4 shadow-[0_0_180px_50px]",
            whichColor(themeColor, "shadow")
          )}
        />
      </div>
    </>
  );
};
