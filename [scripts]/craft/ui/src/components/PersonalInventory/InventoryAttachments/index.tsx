import classNames from "classnames";
import { BottomLine } from "../../BottomLine";
import useData from "../../../hooks/useData";
import { WeaponAttachmentsProps } from "../../../types/DataProviderTypes";
import { DragDropContext, Draggable, Droppable } from "react-beautiful-dnd";
import { isEnvBrowser, whichColor } from "../../../utils/misc";
import useLocales from "../../../hooks/useLocales";

export const InventoryAttachments = () => {
  const { inventoryAttachments, addAttachment, themeColor } = useData();
  const { locale } = useLocales();
  
  const handleAddAttachment = (item: WeaponAttachmentsProps) => {
    if (isEnvBrowser()) return;
    addAttachment(item);
  };

  const onDragEnd = ({
    destination,
    draggableId,
  }: {
    destination: any;
    draggableId: string;
  }) => {
    if (destination) return;
    const inventoryIndex = parseInt(draggableId.split("-")[1]);
    if (inventoryIndex >= 0) {
      const item = inventoryAttachments[inventoryIndex];
      if (item) {
        handleAddAttachment(item);
      }
    }
  };

  return (
    <>
      <div>
        <div className="max-h-[70vh] volta ltr w-full overflow-auto">
          <DragDropContext onDragEnd={onDragEnd}>
            <Droppable droppableId="all-attachments" type="attachments">
              {(provided) => (
                <>
                  <div
                    ref={provided.innerRef}
                    {...provided.droppableProps}
                    className="flex flex-col gap-3"
                  >
                    {inventoryAttachments.map((item, index) => (
                      <Draggable
                        key={index}
                        draggableId={"attachment-" + index}
                        index={index}
                      >
                        {(_provided, s) => (
                          <div
                            ref={_provided.innerRef}
                            className={classNames(
                              "w-[320px] shrink-0 cursor-pointer acc hover:brightness-150",
                              { "brightness-150": s.isDragging }
                            )}
                            {..._provided.dragHandleProps}
                            {..._provided.draggableProps}
                          >
                            <div
                              className={classNames(
                                "min-h-[112px] w-full flex"
                              )}
                            >
                              <div
                                className={classNames(
                                  "flex items-center p-2.5 rounded-l-lg border bg-[#444]",
                                  s.isDragging &&
                                    whichColor(themeColor, "background"),
                                  s.isDragging &&
                                    whichColor(themeColor, "border"),
                                  !s.isDragging && "border-[#444]"
                                )}
                              >
                                <svg
                                  width="9"
                                  height="18"
                                  viewBox="0 0 9 18"
                                  fill="none"
                                  xmlns="http://www.w3.org/2000/svg"
                                  className={classNames(
                                    "fill-[#313131]",
                                    s.isDragging && "!fill-white"
                                  )}
                                >
                                  <path
                                    id="Vector"
                                    d="M0.0521748 16.9557C0.00855103 17.0703 -0.00809978 17.1944 0.00366719 17.3174C0.0154342 17.4404 0.055263 17.5584 0.119698 17.6613C0.184132 17.7642 0.271225 17.8489 0.373417 17.9079C0.475608 17.9669 0.58981 17.9985 0.706109 18H5.35155C5.35012 17.8862 5.37207 17.7735 5.41587 17.6696L9 9L5.42659 0.330378C5.37909 0.227427 5.35347 0.114641 5.35155 0H0.706109C0.592023 0.00262642 0.480187 0.0342484 0.379956 0.0922165C0.279725 0.150187 0.194014 0.232817 0.12999 0.3332C0.0659669 0.433582 0.0254938 0.5488 0.0119558 0.66921C-0.0015822 0.789623 0.0122085 0.91173 0.0521748 1.02532L3.33972 9L0.0521748 16.9557Z"
                                  />
                                </svg>
                              </div>
                              <div
                                className={classNames(
                                  "border border-[#444] w-full flex items-center p-3 bg-444-linear overflow-hidden"
                                )}
                              >
                                <div className="min-w-[5.5rem] min-h-[5.5rem] h-full bg-[#444] bg-opacity-35 flex items-center justify-center">
                                  <img
                                    src={`images/weapons/${item.image}`}
                                    alt="attachments-img"
                                    className="w-12 h-12"
                                  />
                                </div>
                                <div className="mb-auto ml-3 my-1.5 w-full h-full overflow-hidden">
                                  <div
                                    className={classNames(
                                      "text-start text-[#787878] flex items-center"
                                    )}
                                  >
                                    <div className="mr-1 mb-auto">
                                      <img
                                        src="images/slashes.svg"
                                        alt="slashes"
                                        className="w-8 h-8"
                                      />
                                    </div>
                                    <div className="w-full overflow-hidden">
                                      <h1 className="font-extrabold font-Akira text-[11px] tracking-widest">
                                        {item.weapon_name}
                                      </h1>
                                      <h1 className="text-[#444] font-Akira text-[11px]">
                                        {item.label}
                                      </h1>
                                    </div>
                                  </div>
                                  <div className="flex mt-1.5">
                                    <div className="mr-[3px] w-[3px] bg-[#444]"></div>
                                    <div>
                                      <h1 className="bg-[#444] text-[#787878] font-Akira text-[11px] p-0.5 px-1 h-[17px]">
                                        {locale.text_note_equipped}
                                      </h1>
                                    </div>
                                  </div>
                                </div>
                              </div>
                            </div>
                          </div>
                        )}
                      </Draggable>
                    ))}
                    {provided.placeholder}
                  </div>
                </>
              )}
            </Droppable>
          </DragDropContext>
        </div>
        <BottomLine direction="rtl" />
      </div>
    </>
  );
};
