import React from "react";
import useRouter from "../hooks/useRouter";
import Panel from "./Panel";

const App: React.FC = () => {
  const { page } = useRouter();
  return <Panel>{page}</Panel>;
};

export default App;
