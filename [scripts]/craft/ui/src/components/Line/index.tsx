import React from "react";

interface LineBetweenDivsProps {
  x: number;
  y: number;
  shift_top: number;
  shift_left: number;
}

const Line: React.FC<LineBetweenDivsProps> = ({
  x,
  y,
  shift_top,
  shift_left,
}) => {
  const x1 = x * 100 + shift_left;
  const y1 = y * 100 + shift_top;
  const x2 = x * 100;
  const y2 = y * 100;
  const length = Math.sqrt((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1));
  const angle = (Math.atan2(y2 - y1, x2 - x1) * 180) / Math.PI;

  const lineStyle: React.CSSProperties = {
    position: "absolute",
    top: `${y1}%`,
    left: `${x1}%`,
    width: `${length}%`,
    height: "1px",
    transform: `rotate(${angle}deg)`,
    transformOrigin: "0 0",
  };

  return <div className="bg-[#f9fcfd]/40" style={lineStyle} />;
};

export default Line;
