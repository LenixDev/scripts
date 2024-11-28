import classNames from "classnames";
import { CompassHud } from "../../components/CompassHud";
import { StatusBars } from "../../components/StatusBars";
import { VehicleHud } from "../../components/VehicleHud";
import useData from "../../hooks/useData";
import { useEffect, useState } from "react";

const Home = () => {
  const { vehicleHud } = useData();
  const [orgVehicleHudStyle, setOrgVehicleHudStyle] = useState<{
    bottom: number;
    left: number;
  }>({
    bottom: 0,
    left: 0,
  });

  useEffect(() => {
    const vehicleHudContainer = document.querySelector(
      "div.vehicleHudContainer"
    ) as HTMLElement;
    setOrgVehicleHudStyle({
      bottom: parseInt(vehicleHudContainer.style.bottom, 10),
      left: parseInt(vehicleHudContainer.style.left, 10),
    });
  }, []);

  useEffect(() => {
    if (orgVehicleHudStyle.bottom != 0 && orgVehicleHudStyle.left != 0) {
      const vehicleHudContainer = document.querySelector(
        "div.vehicleHudContainer"
      );
      if (vehicleHudContainer instanceof HTMLElement) {
        const _bottom =
          orgVehicleHudStyle.bottom + vehicleHud?.position?.bottom;
        const _left = orgVehicleHudStyle.left + vehicleHud?.position?.left;
        vehicleHudContainer.style.left = _left + "px";
        vehicleHudContainer.style.bottom = _bottom + "px";
      }
    }
  }, [vehicleHud?.position, orgVehicleHudStyle]);

  return (
    <div>
      {/* Start Status Bars */}
      <div className="absolute bottom-2 left-6">
        <StatusBars />
      </div>
      {/* End Status Bars */}
      {/* Start Car Hud */}
      <div
        className={classNames("absolute vehicleHudContainer")}
        style={{
          left: "352px",
          bottom: "64px",
        }}
      >
        <VehicleHud />
      </div>
      {/* End Car Hud */}
      {/* Start Compass Hud */}
      <div className="absolute top-0 w-full">
        <CompassHud />
      </div>
      {/* End Compass Hud */}
    </div>
  );
};
export default Home;
