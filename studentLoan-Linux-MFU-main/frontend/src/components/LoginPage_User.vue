<template>
  <AlertBox ref="alertBox" />
  <div class="vh-100 img-background">
    <div
      class="d-flex flex-column justify-content-center align-items-center vh-100"
    >
      <!-- Login Box -->
      <div
        class="bg-white bg-opacity-75 my-auto rounded-4 shadow m-5 text-center"
        style="max-width: 500px; max-height: 430px"
      >
        <div class="p-5">
          <div>
            <img src="../assets/mfu_icon.png" alt="mfu_icon" width="30px" />
            <p class="Noto">มหาวิทยาลัยแม่ฟ้าหลวง</p>
          </div>
          <h3 class="mt-5">
            <p class="Noto">
              ระบบส่งแบบคำขอกู้ยืมเงินกองทุนเงินให้กู้ยืมเพื่อการศึกษา (กยศ.)
            </p>
          </h3>
          <div>
            <div
              class="row g-2 bg-light bg-opacity-75 rounded-3 shadow text-center p-3"
            >
              <GoogleLogin
                :callback="callback"
                class="d-flex justify-content-center align-items-center mb-2"
              />
              <p style="font-size: 10px; color: grey; margin: 0px" class="Noto">
                เข้าสู่ระบบด้วยบัญชีนักศึกษาของมหาวิทยาลัยแม่ฟ้าหลวงเท่านั้น
              </p>
            </div>
          </div>
        </div>
        <div class="pb-3 pe-5 float-end">
          <a
            href="https://drive.google.com/file/d/1NRPcK26MyHBEds1grE1C42kH6qK8i7NE/view?usp=sharing"
            class="Noto"
            target="_blank"
            rel="noopener noreferrer"
            >คู่มือ/วิธีการใช้งานระบบ</a
          >
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { GoogleLogin } from "vue3-google-login";
import AlertBox from "./AlertBox.vue";

export default {
  components: {
    GoogleLogin,
    AlertBox,
  },
  data() {
    return {};
  },
  methods: {
    async postSessionSave(id_token) {
      try {
        const response = await fetch(
          `${process.env.VUE_APP_API_BASE_URL}/session/login/save/session`,
          {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ token: id_token }),
            credentials: "include",
          }
        );

        const res = await response.json();
        if (response.ok) {
          this.$refs.alertBox.showAlert(res.message, "success");
          this.$router.push(res.role === "user" ? "/user" : "/staff");
        } else {
          throw new Error(res.error || "Login failed");
        }
      } catch (error) {
        console.error(error);
        this.$refs.alertBox?.showAlert(error.message, "error");
      }
    },

    async getSession() {
      try {
        const response = await fetch(
          `${process.env.VUE_APP_API_BASE_URL}/session/get/session`,
          {
            method: "GET",
            credentials: "include",
          }
        );
        if (response.ok) {
          const session = await response.json();
          if (session.role == "user") {
            this.$router.push("/user");
          } else {
            this.$router.push("/staff");
          }
        } else if (response.status === 401) {
          return this.$refs.alertBox.showAlert("กรุณาล็อคอิน", "warning");
        } else if (response.status === 500) {
          const errorMessage = await response.text();
          throw new Error(errorMessage);
        } else {
          throw new Error("Connection error");
        }
      } catch (error) {
        console.error(error.message);
        alert(error.message);
      }
    },

    callback(response) {
      if (!response || !response.credential) {
        this.$refs.alertBox?.showAlert("เข้าสู่ระบบไม่สำเร็จ", "error");
        return;
      }
      this.postSessionSave(response.credential);
    },
  },
  mounted() {
    this.getSession();
  },
};
</script>

<style scoped>
.img-background {
  position: relative;
  z-index: 0;
}

.img-background::before {
  content: "";
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-image: url("../assets/Login_background.jpeg");
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
  opacity: 0.5;
  z-index: -1;
}

/* src/assets/css/fonts.css */
@font-face {
  font-family: "Noto Sans Thai";
  src: url("@/assets/fonts/Noto_Sans_Thai/NotoSansThai-VariableFont_wdth,wght.ttf")
    format("truetype");
  font-weight: normal;
  font-style: normal;
  font-display: swap;
}
.Noto {
  font-family: "Noto Sans Thai", sans-serif;
}

@media (max-width: 768px) {
}
</style>
