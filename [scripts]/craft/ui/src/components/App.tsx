import React from "react";
import Panel from "./Panel";
import useRouter from "../hooks/useRouter";

const App: React.FC = () => {
  const { page } = useRouter();
  return (
    <>
      <Panel>{page}</Panel>
    </>
  );
};

export default App;
