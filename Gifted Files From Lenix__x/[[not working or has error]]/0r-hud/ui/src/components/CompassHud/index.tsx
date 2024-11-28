import { useEffect } from "react";
import useData from "../../hooks/useData";
import "./index.sass";

export const CompassHud = () => {
  const { compassHud } = useData();

  useEffect(() => {
    if (compassHud.heading) {
      const value = compassHud.heading;
      const compassContainer: HTMLElement | null = document.querySelector(
        ".direction .directions"
      );
      if (compassContainer) {
        compassContainer.setAttribute("viewBox", value - 90 + " 0 180 1.5");
      }
    }
  }, [compassHud.heading]);

  return (
    <>
      {compassHud.active && compassHud.show && (
        <div className="w-min mx-auto">
          <div className="flex relative justify-center gap-2">
            <div className="street1">
              <h1 className="text-white font-semibold whitespace-nowrap">
                {compassHud?.crossRoad?.street1}
              </h1>
            </div>
            <div className="direction relative flex justify-center px-2">
              <div className="triangle-bottom absolute z-50"></div>
              <div className="relative m-[0_auto] font-medium text-white w-[240px]">
                <svg className="directions transition-transform h-6 w-full">
                  <text x="0" y="4.5" fill="white" textAnchor="middle">
                    N
                  </text>
                  <text x="360" y="4.5" fill="white" textAnchor="middle">
                    N
                  </text>
                  <text
                    className="side"
                    x="315"
                    y="4.5"
                    fill="white"
                    textAnchor="middle"
                  >
                    NW
                  </text>
                  <text
                    className="side"
                    x="-45"
                    y="4.5"
                    fill="white"
                    textAnchor="middle"
                  >
                    NW
                  </text>

                  <text
                    className="side"
                    x="45"
                    y="4.5"
                    fill="white"
                    textAnchor="middle"
                  >
                    NE
                  </text>
                  <text
                    className="side"
                    x="405"
                    y="4.5"
                    fill="white"
                    textAnchor="middle"
                  >
                    NE
                  </text>

                  <text x="90" y="4.5" fill="white" textAnchor="middle">
                    E
                  </text>
                  <text
                    className="side"
                    x="135"
                    y="4.5"
                    fill="white"
                    textAnchor="middle"
                  >
                    SE
                  </text>
                  <text
                    className="side"
                    x="180"
                    y="4.5"
                    fill="white"
                    textAnchor="middle"
                  >
                    SE
                  </text>
                  <text
                    className="side"
                    x="225"
                    y="4.5"
                    fill="white"
                    textAnchor="middle"
                  >
                    SW
                  </text>
                  <text x="270" y="4.5" fill="white" textAnchor="middle">
                    W
                  </text>
                </svg>
              </div>
            </div>
            <div className="street2">
              <h1 className="text-white font-semibold whitespace-nowrap">
                {compassHud?.crossRoad?.street2}
              </h1>
            </div>
          </div>
        </div>
      )}
    </>
  );
};
