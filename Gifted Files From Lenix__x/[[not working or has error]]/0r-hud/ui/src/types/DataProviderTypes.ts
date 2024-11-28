import { HexagonColors } from "./BasicTypes";

export type StatusBarsProps = {
  type: 1 | 2 | 3 | 4;
  voice: {
    active: boolean;
    color: HexagonColors;
    microphone: boolean;
    radio: boolean;
    isTalking: boolean;
    isTalkingColor: HexagonColors;
    range: number;
  };
  health: {
    active: boolean;
    color: HexagonColors;
    progressLevel: number;
    autoHide: number;
  };
  armor: {
    active: boolean;
    color: HexagonColors;
    progressLevel: number;
    autoHide: number;
  };
  hunger: {
    active: boolean;
    color: HexagonColors;
    progressLevel: number;
    autoHide: number;
  };
  thirst: {
    active: boolean;
    color: HexagonColors;
    progressLevel: number;
    autoHide: number;
  };
  oxygen: {
    active: boolean;
    color: HexagonColors;
    progressLevel: number;
    autoHide: number;
  };
  stamina: {
    active: boolean;
    color: HexagonColors;
    progressLevel: number;
    autoHide: number;
  };
  stress: {
    active: boolean;
    color: HexagonColors;
    progressLevel: number;
    autoHide: number;
  };
  terminal: {
    active: boolean;
    color: HexagonColors;
    progressLevel: number;
    autoHide: number;
  };
  leaf: {
    active: boolean;
    color: HexagonColors;
    progressLevel: number;
    autoHide: number;
  };
};

export type VehicleHudProps = {
  hidden: boolean;
  entity: number;
  kmH: boolean;
  type: 1 | 2 | 3;
  show: boolean;
  isSeatbeltOn: boolean;
  isPassenger: boolean;
  cruiseControlStatus: boolean;
  inVehicle: boolean;
  fuel: {
    type: "electric" | "gasoline";
    level: number;
    max_level: number;
  };
  speed: number;
  engineHealth: number;
  rpm: number;
  gear: number | "N" | "R";
  miniMaP: {
    style: "square" | "circle";
  };
  speedoMeter: {
    fps: number;
  };
  position: {
    bottom: number;
    left: number;
  };
  lightsOn: boolean;
  manualMode: boolean;
  manualModeType: boolean;
};

export type CompassHudProps = {
  active: boolean;
  show: boolean;
  heading: number;
  crossRoad: {
    street1: string;
    street2: string;
  };
};

export type DataContextProps = {
  vehicleHud: VehicleHudProps;
  setVehicleHud: React.Dispatch<React.SetStateAction<VehicleHudProps>>;
  statusBars: StatusBarsProps;
  setStatusBars: React.Dispatch<React.SetStateAction<StatusBarsProps>>;
  compassHud: CompassHudProps;
  setCompassHud: React.Dispatch<React.SetStateAction<CompassHudProps>>;
  saveSettings: (type: string) => void;
};
