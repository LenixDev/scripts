import React, { createContext, useMemo, useState } from "react";
import { useNuiEvent } from "../hooks/useNuiEvent";
import { isEnvBrowser } from "../utils/misc";
import { debugData } from "../utils/debugData";
import classNames from "classnames";

debugData([
  {
    action: "setVisible",
    data: true,
  },
]);

export interface VisibilityProviderValue {
  setVisible: (visible: boolean) => void;
  visible: boolean;
}

export const VisibilityCtx = createContext<VisibilityProviderValue>(
  {} as VisibilityProviderValue
);

export const VisibilityProvider: React.FC<{ children: React.ReactNode }> = ({
  children,
}) => {
  const [visible, setVisible] = useState(false);

  useNuiEvent<boolean>("setVisible", setVisible);

  const value = useMemo(() => {
    return {
      visible,
      setVisible,
    };
  }, [visible]);

  return (
    <VisibilityCtx.Provider value={value}>
      <main
        style={{ visibility: visible ? "visible" : "hidden" }}
        className={classNames(
          "content transition-opacity duration-500",
          {
            "bg-zinc-900": isEnvBrowser(),
          },
          {
            visible: visible,
          },
          { hidden: !visible },
          {
            "opacity-100": visible,
          },
          {
            "opacity-0": !visible,
          }
        )}
      >
        {children}
      </main>
    </VisibilityCtx.Provider>
  );
};
