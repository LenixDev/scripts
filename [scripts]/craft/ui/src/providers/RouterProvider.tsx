import React, { createContext, useEffect, useMemo, useState } from "react";
import { RouterProviderProps, RouterTypes } from "../types/RouterProviderTypes";
import Craft from "../pages/Craft";

export const RouterCtx = createContext<RouterProviderProps>(
  {} as RouterProviderProps
);

export const RouterProvider: React.FC<{ children: React.ReactNode }> = ({
  children,
}) => {
  const [router, setRouter] = useState<RouterTypes>("Craft");
  const [page, setPage] = useState<React.ReactNode | null>(null);

  useEffect(() => {
    if (router == "Craft") setPage(<Craft />);
    else setPage(<Craft />);
  }, [router]);

  const value = useMemo(() => {
    return {
      router,
      setRouter,
      page,
      setPage,
    };
  }, [router, page]);

  return <RouterCtx.Provider value={value}>{children}</RouterCtx.Provider>;
};

export default RouterProvider;
