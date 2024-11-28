import classNames from "classnames";
import useLocales from "../../hooks/useLocales";
import { HexagonColors } from "../../types/BasicTypes";
import { inheritColor } from "../../utils/misc";

interface ColorSelectorProps {
  color: HexagonColors;
  handleOnChange: (event: React.ChangeEvent<HTMLSelectElement>) => void;
}

export const ColorSelector: React.FC<ColorSelectorProps> = ({
  color,
  handleOnChange,
}) => {
  const { locale } = useLocales();

  const hexagonColorValues: HexagonColors[] = [
    "gray",
    "green",
    "blue",
    "orange",
    "cyan",
    "red",
    "zinc",
    "yellow",
    "black",
    "amber",
    "emerald",
    "purple",
    "lime",
  ];

  const colorCalculator = (color: HexagonColors): string => {
    return inheritColor[color];
  };

  const colorOptions: JSX.Element[] = [
    <option key="" value="" disabled>
      {locale.settings_text_color}
    </option>,
    ...Object.values(hexagonColorValues).map((colorOption) => (
      <option key={colorOption} value={colorOption}>
        {colorOption.charAt(0).toUpperCase() + colorOption.slice(1)}
      </option>
    )),
  ];

  return (
    <>
      <label htmlFor="colorSelector" className="sr-only">
        Color
      </label>
      <div className="flex justify-center items-center">
        <div
          className={classNames(
            "h-[30px] w-full border border-[#2D2D2D]",
            colorCalculator(color)
          )}
        ></div>
        <select
          id="colorSelector"
          className="bg-[#272727] border border-[#2D2D2D] text-white text-[10px] py-1.5 ring-0 outline-none font-bold px-4"
          value={color}
          onChange={handleOnChange}
        >
          {colorOptions}
        </select>
      </div>
    </>
  );
};
