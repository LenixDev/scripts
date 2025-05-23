import ReactDOM from "react-dom/client";
import App from "./components/App";
import "./index.css";
import { VisibilityProvider } from "./providers/VisibilityProvider";
import { RouterProvider } from "./providers/RouterProvider";
import { DataProvider } from "./providers/DataProvider";
import { LocaleProvider } from "./providers/LocaleProvider";

ReactDOM.createRoot(document.getElementById("root")!).render(
  <>
    <VisibilityProvider>
      <RouterProvider>
        <LocaleProvider>
          <DataProvider>
            <App />
          </DataProvider>
        </LocaleProvider>
      </RouterProvider>
    </VisibilityProvider>
  </>
);
