import classNames from "classnames";
import { BottomLine } from "../BottomLine";
import "./index.sass";
import { whichColor } from "../../utils/misc";
import useData from "../../hooks/useData";
import { FC } from "react";
import { ThemeColorProps } from "../../types/BasicTypes";

type IngredientBoxProps = {
  name: string;
  label: string;
  need: number;
  count: number;
  themeColor: ThemeColorProps;
};

export const CraftingIngredients = () => {
  const { themeColor, selectedCraftableItem } = useData();
  const ingredients = Object.values(selectedCraftableItem?.ingredients || {});

  const JSX_IngredientBox: FC<IngredientBoxProps> = ({
    name,
    label,
    need,
    count,
    themeColor,
  }) => {
    if (!name) {
      return (
        <div className="w-[72px] h-[72px] p-1 bg-cover bg-no-repeat flex flex-col items-center justify-center border border-[#444444] bg-[#424242]/20"></div>
      );
    }

    const imagePath = name.toLowerCase().includes("weapon_")
      ? "images/weapons/"
      : "images/items/";
    const imageName = name.toLowerCase() + ".png";

    return (
      <div className="w-[72px] h-[72px] p-1 bg-cover bg-no-repeat flex flex-col items-center justify-center border border-[#444444] bg-[#424242]/20 hover:border-white/60 cursor-pointer">
        <div className="p-0.5 max-w-10 max-h-10 w-full h-full">
          <img src={`${imagePath}${imageName}`} alt={name} />
        </div>
        <div className="max-w-16 w-full">
          <div className="overflow-auto text-center whitespace-nowrap no-scrollbar mb-0.5">
            <h1 className="ingredient-name text-ellipsis">{label}</h1>
          </div>
          <div className="overflow-auto text-center whitespace-nowrap no-scrollbar">
            <h1
              className={classNames("ingredient-count text-ellipsis", {
                [whichColor(themeColor, "text")]: count >= need,
                not_enough: count < need,
              })}
            >
              {count}/{need}
            </h1>
          </div>
        </div>
      </div>
    );
  };

  return (
    <div className="mt-auto">
      <div className="grid grid-cols-4 gap-2 max-h-[234px] volta ltr">
        {ingredients.length > 0 &&
          Array.from({
            length: Math.max(Math.ceil(ingredients.length / 4) * 4, 12),
          }).map((_, index) => {
            const ingredient = ingredients[index] || {};
            return (
              <JSX_IngredientBox
                key={index}
                name={ingredient.name}
                need={ingredient.need}
                count={ingredient.count}
                label={ingredient.label}
                themeColor={themeColor}
              />
            );
          })}
      </div>
      <BottomLine direction="rtl" />
    </div>
  );
};
