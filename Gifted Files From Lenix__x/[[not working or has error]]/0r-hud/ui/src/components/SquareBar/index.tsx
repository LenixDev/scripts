import classNames from "classnames";
import { StatusBarProps } from "../../types/BasicTypes";
import "./index.sass";

export const SquareBar: React.FC<StatusBarProps> = ({
  color,
  children,
  occupancy,
  hidden,
  animDelay,
}) => {
  color = color ?? "gray";

  const afterColor = {
    gray: "after:bg-gray-500",
    green: "after:bg-green-500",
    blue: "after:bg-blue-700",
    orange: "after:bg-orange_bar",
    cyan: "after:bg-cyan_bar",
    red: "after:bg-red-500",
    zinc: "after:bg-zinc-300",
    black: "after:bg-black",
    yellow: "after:bg-yellow-500",
    amber: "after:bg-amber-500",
    lime: "after:bg-lime_bar",
    emerald: "after:bg-emerald-600",
    purple: "after:bg-purple-600",
  };
  const inheritColor = {
    gray: "bg-gray-500",
    green: "bg-green-500",
    blue: "bg-blue-700",
    orange: "bg-orange_bar",
    cyan: "bg-cyan_bar",
    red: "bg-red-500",
    zinc: "bg-zinc-300",
    black: "bg-black",
    yellow: "bg-yellow-500",
    amber: "bg-amber-500",
    lime: "bg-lime_bar",
    emerald: "bg-emerald-600",
    purple: "bg-purple-600",
  };
  const box1OpacityColor = {
    gray: "bg-gray-200/20",
    green: "bg-green-500/20",
    blue: "bg-blue-500/20",
    orange: "bg-orange_bar/20",
    cyan: "bg-cyan_bar/20",
    red: "bg-red_bar/20",
    zinc: "bg-zinc-400/20",
    black: "bg-black/20",
    yellow: "bg-yellow-300/20",
    amber: "bg-amber-300/20",
    lime: "bg-lime_bar/20",
    emerald: "bg-emerald-300/20",
    purple: "bg-purple-300/20",
  };
  const box2OpacityColor = {
    gray: "bg-gray-200/30",
    green: "bg-green-500/30",
    blue: "bg-blue-500/20",
    orange: "bg-orange_bar/30",
    cyan: "bg-cyan_bar/20",
    red: "bg-red_bar/30",
    zinc: "bg-zinc-400/30",
    black: "bg-black/30",
    yellow: "bg-yellow-300/30",
    amber: "bg-amber-300/30",
    lime: "bg-lime_bar/30",
    emerald: "bg-emerald-300/30",
    purple: "bg-purple-300/30",
  };

  return (
    <>
      <div
        hidden={hidden}
        className={classNames(
          "w-12 h-12 rounded-[10px] relative box1",
          box1OpacityColor[color]
        )}
      >
        <div className="flex items-center justify-center w-full h-full box2">
          <div className="absolute z-10">{children}</div>
          <div
            className={classNames(
              "w-[38px] h-[38px] rounded-[10px] relative box3 overflow-hidden",
              box2OpacityColor[color]
            )}
          >
            <div
              className={classNames(
                "absolute w-full bottom-0 box4 anim",
                inheritColor[color],
                afterColor[color]
              )}
              style={{
                height: occupancy + "%",
                animationDelay: animDelay || "0ms",
              }}
            ></div>
          </div>
        </div>
      </div>
    </>
  );
};
