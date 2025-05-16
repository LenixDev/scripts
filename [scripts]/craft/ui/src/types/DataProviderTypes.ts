import { MenuProps, ThemeColorProps } from "./BasicTypes";

export type WeaponAttachmentsProps = {
  index: number;
  image: string;
  label: string;
  name: string;
  hash: string;
  type: string;
  weapon_name: string;
};

export type WeaponProps = {
  index: number;
  name: string;
  label: string;
  image: string;
  amount: number;
  attachments: WeaponAttachmentsProps[];
  object?: number;
  _item?: any;
};

export type AttachmentBoxesProps = {
  key: string;
  y: number;
  x: number;
  label: string;
  slot: string;
  shift_left: number;
  shift_top: number;
  child: WeaponAttachmentsProps | null;
};

export type IngredientProps = {
  name: string;
  label: string;
  need: number;
  count: number;
};

export type IngredientsProps = {
  [item_name: string]: IngredientProps;
};

export type CraftableItemProps = {
  index: number;
  name: string;
  label: string;
  count: number;
  duration: number;
  image: string;
  ingredients: IngredientsProps;
  propModel: string;
  price: number;
  canItBeCraftable?: boolean;
  remaining?: number;
  object?: number;
};

export type CraftableItemsProps = {
  [key: string]: CraftableItemProps;
};

export type QueueProps = CraftableItemProps;

export type CraftingQueueProps = QueueProps;

export type DataContextProps = {
  inventoryWeapons: WeaponProps[];
  inventoryAttachments: WeaponAttachmentsProps[];
  themeColor: ThemeColorProps;
  setThemeColor: React.Dispatch<React.SetStateAction<ThemeColorProps>>;
  activeMenu: MenuProps;
  setActiveMenu: React.Dispatch<React.SetStateAction<MenuProps>>;
  selectedItem: WeaponProps;
  setSelectedItem: React.Dispatch<React.SetStateAction<WeaponProps>>;
  attachmentBoxes: AttachmentBoxesProps[];
  setAttachmentBoxes: React.Dispatch<
    React.SetStateAction<AttachmentBoxesProps[]>
  >;
  CraftableItems: CraftableItemProps[];
  selectedCraftableItem: CraftableItemProps;
  setSelectedCraftableItem: React.Dispatch<
    React.SetStateAction<CraftableItemProps>
  >;
  CraftingQueue: CraftingQueueProps[];
  CompletedCraftingQueue: CraftingQueueProps[];
  addAttachment: (attachment: WeaponAttachmentsProps) => void;
  removeAttachment: (attachment: WeaponAttachmentsProps) => void;
  loadSelectedWeapon: (weapon: WeaponProps) => void;
  changeActivePage: (page: MenuProps) => void;
  loadSelectedCraftableItem: (item: CraftableItemProps) => void;
  AddSelectedItemToCraftingQueue: () => Promise<boolean>;
  ItemPickUp: (queue: QueueProps) => Promise<boolean>;
};
