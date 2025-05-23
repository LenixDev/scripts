import { useEffect, useRef, useState } from "react";
import useData from "../../hooks/useData";
import { isEnvBrowser } from "../../utils/misc";
import { fetchNui } from "../../utils/fetchNui";

export const CraftingMiddle: React.FC = () => {
  const { selectedCraftableItem } = useData();
  const [isDragging, setDragging] = useState(false);
  const [lastX, setLastX] = useState(0);
  const [lastY, setLastY] = useState(0);
  const craftingRef = useRef<HTMLDivElement | null>(null);

  useEffect(() => {
    const handleMouseMove = (event: MouseEvent) => {
      const x = event.clientX;
      const y = event.clientY;

      if (isDragging && craftingRef.current) {
        const style = window.getComputedStyle(craftingRef.current);

        if (style && lastX != 0 && lastY != 0) {
          const factor = 30 / parseInt(style.height.replace("px", ""), 10);
          const dx = Math.min(10.0, factor * (x - lastX) * 3);
          const dy = Math.min(10.0, factor * (y - lastY) * 3);
          fetchNui(
            "nui:UpdateSelectedCraftableItemRotation",
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
    const attachmentElement = craftingRef.current;
    if (attachmentElement && !isEnvBrowser()) {
      attachmentElement.addEventListener("mousemove", handleMouseMove);
      return () => {
        attachmentElement.removeEventListener("mousemove", handleMouseMove);
      };
    }
  }, [isDragging, lastX, lastY]);

  const handleMouseDown = () => {
    if (!selectedCraftableItem) return;
    setDragging(true);
  };

  const handleMouseUp = () => {
    setDragging(false);
  };

  return (
    <div className="w-full h-full relative z-10">
      {selectedCraftableItem.object && selectedCraftableItem.object > -1 && (
        <div
          ref={craftingRef}
          onMouseDown={handleMouseDown}
          onMouseUp={handleMouseUp}
          onMouseLeave={handleMouseUp}
          className="w-full h-full"
        />
      )}
    </div>
  );
};
