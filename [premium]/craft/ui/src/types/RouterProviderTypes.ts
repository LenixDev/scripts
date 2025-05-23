export type RouterTypes = "Craft";

export type RouterProviderProps = {
  router: RouterTypes;
  setRouter: (router: RouterTypes) => void;
  page: React.ReactNode;
};
