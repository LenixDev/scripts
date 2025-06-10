import { InventoryAttachments } from "./InventoryAttachments";
import { InventoryGun } from "./InventoryGun";

export const PersonalInventory: React.FC<{
  type: "gun" | "attachments";
}> = ({ type }) => {
  return (
    <>
      <div className="mt-4">
        {type == "gun" && <InventoryGun />}
        {type == "attachments" && <InventoryAttachments />}
      </div>
    </>
  );
};
