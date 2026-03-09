import { createApp } from "vue";
import App from "./App.vue";
import "bootstrap";
import "bootstrap/dist/css/bootstrap.min.css";
import { createRouter, createWebHistory } from "vue-router/dist/vue-router";
import "@fortawesome/fontawesome-free/css/all.css";

//Login
import LoginPage from "./components/LoginPage.vue";
import LoginPage_User from "./components/LoginPage_User.vue";
import LoginPage_Staff from "./components/LoginPage_Staff.vue";

// User
import UserPage_home from "./components/User/UserPage_home.vue";
import UserPage_loan from "./components/User/UserPage_loan.vue";
import UserPage_info from "./components/User/UserPage_info.vue";
import UserPage_Popup from "./components/User/User_popUp_secondTerm_Loan.vue";
import UserPage_loan_secondSemester from "./components/User/UserPage_loan_secondSemester.vue";
import NavBar_User from "./components/User/NavBar_user.vue";


//Staff
import StaffPage_home from "./components/Staff/StaffPage_home.vue";
import NavBar_staff from "./components/Staff/NavBar_staff.vue";
import StaffPage_info from "./components/Staff/StaffPage_info.vue";
import StaffPage_setting from "./components/Staff/StaffPage_setting.vue";
import StaffPage_userCheck from "./components/Staff/StaffPage_userCheck.vue";

// Google
import GoogleLogin from "vue3-google-login";

// Extension
import AlertBox from "./components/AlertBox.vue";




// Create routes
const routes = [
  {
    path: "/",
    redirect: "/login", 
  },
  {
    path: "/login",
    name: "LoginPage",
    components: {
      default: LoginPage,
      AlertBox: AlertBox,
    },
  },
  {
    path: "/login/user",
    name: "LoginPage_User",
    components: {
      default: LoginPage_User,
      AlertBox: AlertBox,
    },
  },
  {
    path: "/login/staff",
    name: "LoginPage_Staff",
    components: {
      default: LoginPage_Staff,
      AlertBox: AlertBox,
    },
  },
  // User route
  {
    path: "/user",
    name: "UserPage_home",
    components: {
      default: UserPage_home,
      navbar: NavBar_User,
      AlertBox: AlertBox,
    },
  },
  {
    path: "/user/info",
    name: "UserPage_info",
    components: {
      default: UserPage_info,
      navbar: NavBar_User,
      AlertBox: AlertBox,
    },
  },
  {
    path: "/user/loan",
    name: "UserPage_loan",
    components: {
      default: UserPage_loan,
      navbar: NavBar_User,
      AlertBox: AlertBox,
    },
  },
  {
    path: "/user/loan/secondSemester",
    name: "UserPage_loan_secondSemester",
    components: {
      default: UserPage_loan_secondSemester,
      navbar: NavBar_User,
      AlertBox: AlertBox,
    },
  },
  {
    path: "/user/pop",
    name: "UserPage_Popup",
    components: {
      default: UserPage_Popup,
    },
  },

  // Staff route
  {
    path: "/staff",
    name: "StaffPage_home",
    components: {
      default: StaffPage_home,
      navbar: NavBar_staff,
      AlertBox: AlertBox,
    },
  },
  {
    path: "/staff/info",
    name: "StaffPage_info",
    components: {
      default: StaffPage_info,
      navbar: NavBar_staff,
      AlertBox: AlertBox,
    },
  },

  {
    path: "/staff/setting",
    name: "StaffPage_setting",
    components: {
      default: StaffPage_setting,
      navbar: NavBar_staff,
    },
  },  

  {
    path: "/staff/check/user",
    name: "StaffPage_userCheck",
    components: {
      default: StaffPage_userCheck,
      navbar: NavBar_staff,
      AlertBox: AlertBox,
    },
  },  
];

// Create router
const router = createRouter({
  history: createWebHistory(),
  routes,
});

// Create app
const app = createApp(App);
app.use(GoogleLogin, {
  clientId:
    "690707060882-kotlgl2prqgfqo8rdt2edbf2i2e0e8ki.apps.googleusercontent.com",
});
app.use(router);
app.mount("#app");
