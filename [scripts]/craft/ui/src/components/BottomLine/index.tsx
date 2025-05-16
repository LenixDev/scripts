import classNames from "classnames";
import useData from "../../hooks/useData";
import { whichColor } from "../../utils/misc";

interface BottomLineProps {
  direction?: "ltr" | "rtl";
}

export const BottomLine: React.FC<BottomLineProps> = ({ direction }) => {
  const { themeColor } = useData();

  return (
    <>
      <div
        className={classNames(
          "flex gap-1 mt-1 w-full",
          {
            "flex-row-reverse": direction == "rtl",
          },
        )}
      >
        <div
          className={classNames(
            "w-1.5 h-1",
            whichColor(themeColor, "background")
          )}
        />
        <div
          className={classNames(
            "w-1.5 h-1",
            whichColor(themeColor, "background")
          )}
        />
        <div
          className={classNames(
            "w-1.5 h-1",
            whichColor(themeColor, "background")
          )}
        />
        <div
          className={classNames(
            "w-full h-1",
            whichColor(themeColor, "background")
          )}
        />
      </div>
    </>
  );
};
