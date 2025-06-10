import React from "react";

const Panel: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  return <div className="relative w-full h-screen">{children}</div>;
};

export default Panel;
