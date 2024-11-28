import React, { ReactNode } from "react";

interface PanelProps {
  children: ReactNode;
}

const Panel: React.FC<PanelProps> = ({ children }) => {
  return <div className="w-full h-screen">{children}</div>;
};

export default Panel;
