import React from 'react';
import {Route} from "react-router-dom"
import HomePage from "./components/pages/HomePage";
import LearnMore from "./components/pages/LearnMore"

const App = () => (

    <div>
        <Route path="/" exact component={HomePage} />
        <Route path="/learnmore" exact component={LearnMore} />
    </div>
);

export default App;