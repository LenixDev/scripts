import React, { createContext, useEffect, useMemo, useState } from "react";
import { useNuiEvent } from "../hooks/useNuiEvent";
import { isEnvBrowser } from "../utils/misc";
import { debugData } from "../utils/debugData";
import classNames from "classnames";
import { fetchNui } from "../utils/fetchNui";

debugData([
  {
    action: "ui:setVisible",
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

  useNuiEvent<boolean>("ui:setVisible", setVisible);

  useEffect(() => {
    if (!visible) return;

    const keyHandler = (e: KeyboardEvent) => {
      if (["Escape"].includes(e.code)) {
        if (!isEnvBrowser()) {
          fetchNui("nui:hideFrame");
          setVisible(false);
        }
      }
    };
    window.addEventListener("keydown", keyHandler);
    return () => window.removeEventListener("keydown", keyHandler);
  }, [visible]);

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
        className={classNames("content", { "bg-black/90": isEnvBrowser() })}
      >
        {children}
      </main>
    </VisibilityCtx.Provider>
  );
};
