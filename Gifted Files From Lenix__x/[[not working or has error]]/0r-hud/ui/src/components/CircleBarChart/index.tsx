import { StatusBarProps } from "../../types/BasicTypes";
import {
  CircularProgressbar,
  CircularProgressbarWithChildren,
  buildStyles,
} from "react-circular-progressbar";
import "react-circular-progressbar/dist/styles.css";
import "./index.sass";

export const CircleBarChart: React.FC<StatusBarProps> = ({
  color,
  occupancy,
  hidden,
  children,
}) => {
  color = color ?? "gray";
  const pathColor = {
    gray: "rgba(107, 114, 128, 1)",
    green: "rgba(34, 197, 94, 1)",
    blue: "rgba(29, 78, 216, 1)",
    orange: "rgba(255, 153, 0, 1)",
    cyan: "rgba(0, 194, 255, 1)",
    red: "rgba(207, 78, 91, 1)",
    zinc: "rgba(212, 212, 216, 1)",
    black: "rgba(0, 0, 0, 1)",
    yellow: "rgba(234, 179, 8, 1)",
    amber: "rgba(245, 158, 11, 1)",
    lime: "rgba(196, 255, 72, 1)",
    emerald: "rgba(22, 163, 74, 1)",
    purple: "rgba(147, 51, 234, 1)",
  };
  const trailColor = {
    gray: "rgba(107, 114, 128, 0.2)",
    green: "rgba(34, 197, 94, 0.2)",
    blue: "rgba(29, 78, 216, 0.2)",
    orange: "rgba(255, 153, 0, 0.2)",
    cyan: "rgba(0, 194, 255, 0.2)",
    red: "rgba(207, 78, 91, 0.2)",
    zinc: "rgba(212, 212, 216, 0.2)",
    black: "rgba(0, 0, 0, 0.2)",
    yellow: "rgba(234, 179, 8, 0.2)",
    amber: "rgba(245, 158, 11, 0.2)",
    lime: "rgba(196, 255, 72, 0.2)",
    emerald: "rgba(22, 163, 74, 0.2)",
    purple: "rgba(147, 51, 234, 0.2)",
  };

  return (
    <div style={{ width: 44, height: 44 }} hidden={hidden}>
      <CircularProgressbarWithChildren
        className="p-1.5"
        value={occupancy || 0}
        styles={buildStyles({
          strokeLinecap: "butt",
          pathColor: pathColor[color],
          trailColor: trailColor["black"],
        })}
        strokeWidth={50}
      >
        <div className="absolute" style={{ color: "white" }}>
          {children}
        </div>
        <CircularProgressbar
          value={occupancy || 0}
          strokeWidth={8}
          styles={buildStyles({
            trailColor: trailColor[color],
            pathColor: pathColor[color],
            strokeLinecap: "butt",
          })}
        />
      </CircularProgressbarWithChildren>
    </div>
  );
};
