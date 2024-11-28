export type HexagonColors =
  | "gray"
  | "green"
  | "blue"
  | "orange"
  | "cyan"
  | "red"
  | "zinc"
  | "yellow"
  | "black"
  | "amber"
  | "emerald"
  | "purple"
  | "lime";

export type StatusBarProps = {
  color?: HexagonColors;
  children?: React.ReactNode;
  occupancy?: number;
  hidden?: boolean;
  noAnim?: boolean;
  icon?: React.ReactNode;
  animDelay?: string;
};

export type SettingsPagesProps = "hud" | "map" | "pause_menu";
