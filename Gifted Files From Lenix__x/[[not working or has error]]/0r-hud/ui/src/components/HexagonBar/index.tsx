import classNames from "classnames";
import "./index.sass";
import { StatusBarProps } from "../../types/BasicTypes";
import { inheritColor } from "../../utils/misc";

export const HexagonBar: React.FC<StatusBarProps> = ({
  color,
  children,
  occupancy,
  hidden,
  noAnim,
}) => {
  color = color ?? "gray";

  const hexagonColor = {
    gray: "bg-gray-500/30",
    green: "bg-green-500/40",
    blue: "bg-blue-700/50",
    orange: "bg-orange_bar/40",
    cyan: "bg-cyan_bar/40",
    red: "bg-red_bar/40",
    zinc: "bg-zinc-300/40",
    black: "bg-black/40",
    yellow: "bg-yellow-500/40",
    amber: "bg-amber-500/40",
    lime: "bg-lime_bar/40",
    emerald: "bg-emerald-600/40",
    purple: "bg-purple-600/40",
  };
  const smallHexagonColor = {
    gray: "bg-gray-200/80",
    green: "bg-green-500/80",
    blue: "bg-blue-500/80",
    orange: "bg-orange_bar/10",
    cyan: "bg-cyan_bar/10",
    red: "bg-red_bar/10",
    zinc: "bg-zinc-400/80",
    black: "bg-black/80",
    yellow: "bg-yellow-300/80",
    amber: "bg-amber-300/80",
    lime: "bg-lime_bar/10",
    emerald: "bg-emerald-300/80",
    purple: "bg-purple-300/80",
  };
  const animAftColor = {
    gray: "after:bg-gray-700",
    green: "after:bg-green-700",
    blue: "after:bg-blue-950",
    orange: "after:bg-orange_bar",
    cyan: "after:bg-cyan_bar",
    red: "after:bg-red_bar",
    zinc: "after:bg-zinc-500",
    black: "after:bg-black",
    yellow: "after:bg-yellow-500",
    amber: "after:bg-amber-500",
    lime: "after:bg-lime_bar",
    emerald: "after:bg-emerald-600",
    purple: "after:bg-purple-600",
  };

  const calculateHeight = (occ: any) => {
    return (35 * occ) / 100;
  };

  return (
    <div className="hexagon-container" hidden={hidden}>
      <div
        className={classNames(
          "hexagon flex items-center justify-center",
          hexagonColor[color]
        )}
      >
        <div className="icon">{children}</div>
        <div className={classNames("small-hexagon", smallHexagonColor[color])}>
          <div
            className={classNames(
              "inherit shadow-inner transition-height after:transition-height",
              inheritColor[color],
              animAftColor[color],
              { anim: !noAnim }
            )}
            style={{ height: `${calculateHeight(occupancy)}px` }}
          ></div>
        </div>
      </div>
    </div>
  );
};
