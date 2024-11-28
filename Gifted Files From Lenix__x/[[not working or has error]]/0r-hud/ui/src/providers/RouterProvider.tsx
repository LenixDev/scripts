import React, { createContext, useEffect, useMemo, useState } from "react";
import { useNuiEvent } from "../hooks/useNuiEvent";
import { PageTypes, RouterProviderProps } from "../types/RouterProviderTypes";
import Home from "../pages/Home";
import Settings from "../pages/Settings";
import { debugData } from "../utils/debugData";

debugData([
  {
    action: "setRouter",
    data: "settings",
  },
]);

export const RouterCtx = createContext<RouterProviderProps>(
  {} as RouterProviderProps
);

export const RouterProvider: React.FC<{ children: React.ReactNode }> = ({
  children,
}) => {
  const [router, setRouter] = useState<PageTypes>("home");
  const [page, setPage] = useState<React.ReactNode | null>(null);

  useNuiEvent("setRouter", setRouter);

  useEffect(() => {
    if (router == "home") setPage(<Home />);
    if (router == "settings") setPage(<Settings />);
  }, [router]);

  const value = useMemo(() => {
    return {
      router,
      setRouter,
      page,
    };
  }, [router, page]);

  return <RouterCtx.Provider value={value}>{children}</RouterCtx.Provider>;
};

export default RouterProvider;
