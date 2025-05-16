import { useEffect, useRef, useState } from "react";
import { fetchNui } from "../../utils/fetchNui";
import useData from "../../hooks/useData";
import "./index.sass";
import { isEnvBrowser } from "../../utils/misc";
import classNames from "classnames";
import { AttachmentBoxesProps } from "../../types/DataProviderTypes";

export const PersonalMiddle: React.FC = () => {
  const { selectedItem, attachmentBoxes, removeAttachment } = useData();
  const [isDragging, setDragging] = useState(false);
  const [lastX, setLastX] = useState(0);
  const [lastY, setLastY] = useState(0);
  const attachmentRef = useRef<HTMLDivElement | null>(null);

  useEffect(() => {
    const handleMouseMove = (event: MouseEvent) => {
      const x = event.clientX;
      const y = event.clientY;

      if (isDragging && attachmentRef.current) {
        const style = window.getComputedStyle(attachmentRef.current);

        if (style && lastX != 0 && lastY != 0) {
          const factor = 30 / parseInt(style.height.replace("px", ""), 10);
          const dx = Math.min(10.0, factor * (x - lastX) * 3);
          const dy = Math.min(10.0, factor * (y - lastY) * 3);
          fetchNui(
            "nui:UpdateSelectedWeaponRotation",
            {
              x: dx,
              y: dy,
            },
            {}
          );
        }
      }
      setLastX(x);
      setLastY(y);
    };
    const attachmentElement = attachmentRef.current;
    if (attachmentElement && !isEnvBrowser()) {
      attachmentElement.addEventListener("mousemove", handleMouseMove);
      return () => {
        attachmentElement.removeEventListener("mousemove", handleMouseMove);
      };
    }
  }, [isDragging, lastX, lastY]);

  const handleMouseDown = () => {
    if (!selectedItem) return;
    setDragging(true);
  };

  const handleMouseUp = () => {
    setDragging(false);
  };

  const handleBoxDoubleClick = (
    event: React.MouseEvent<HTMLDivElement>,
    box: AttachmentBoxesProps
  ) => {
    event.preventDefault();
    const attachment = box.child;
    if (attachment) removeAttachment(attachment);
  };

  return (
    <>
      <div className="w-full h-full relative z-10">
        {selectedItem.object && selectedItem.object > -1 && (
          <div
            ref={attachmentRef}
            onMouseDown={handleMouseDown}
            onMouseUp={handleMouseUp}
            onMouseLeave={handleMouseUp}
            className="w-full h-full"
          />
        )}
      </div>
      <div className="w-full h-full absolute top-0 left-0">
        {attachmentBoxes.map((box, i) => (
          <div key={i}>
            <div
              data-index={i}
              onDoubleClick={(e) => handleBoxDoubleClick(e, box)}
              className={classNames(
                "attachment-box no-selection bg-no-repeat bg-cover font-Akira bg-[#444]/70 border border-white/20 rounded",
                { "cursor-pointer": box?.child },
                { "z-20": box?.child }
              )}
              style={{
                inset: `${box.y * 90 + box.shift_top}% ${
                  100 - box.x * 100 + box.shift_left
                }% ${100 - box.y * 100 + box.shift_top}% ${
                  box.x * 100 + box.shift_left
                }%`,
              }}
            >
              <h1 className="label">{box.label}</h1>
              {box?.child?.image && (
                <div className="image p-2 flex items-center justify-center w-full h-full">
                  <img
                    src={`images/weapons/${box.child.image}`}
                    alt="component-img"
                  />
                </div>
              )}
            </div>
            <div
              className="absolute w-1 h-1 bg-white/50"
              style={{
                inset: `${box.y * 90 + "%"} ${100 - box.x * 100 + "%"} ${
                  100 - box.y * 100 + "%"
                } ${box.x * 100 + "%"}`,
              }}
            />
            {/* <Line
              x={box.x}
              y={box.y}
              shift_left={box.shift_left}
              shift_top={box.shift_top}
            /> */}
          </div>
        ))}
      </div>
    </>
  );
};
