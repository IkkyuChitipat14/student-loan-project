<template>
  <div>
    <AlertBox ref="alertBox" />
    <div class="vh-100 img-background">
      <div class="d-flex flex-column justify-content-center align-items-center vh-100">
        <!-- Login Box -->
        <div class="bg-white bg-opacity-75 my-auto rounded-4 p-5 shadow m-5 text-center" style="max-width: 500px;">
          <div>
            <img src="../assets/mfu_icon.png" alt="mfu_icon" width="30px" />
            <p class="Noto">มหาวิทยาลัยแม่ฟ้าหลวง</p>
          </div>
          <h3 class="mt-5 Noto">
            ระบบส่งแบบคำขอกู้ยืมเงินกองทุนเงินให้กู้ยืมเพื่อการศึกษา (กยศ.)
          </h3>
          <div>
            <div class="row g-2 bg-light bg-opacity-75 rounded-3 shadow text-center p-3 mt-2">
              <div class="col-12 col-md-6">
                <button class="Noto btn btn-outline-dark w-100" @click="$router.push('/login/user')">
                  <i class="fa-solid fa-graduation-cap" style="font-size: 50px"></i>
                  <p class="mb-0">Student</p>
                  <p class="mb-0">นักศึกษา</p>
                </button>
              </div>

              <div class="col-12 col-md-6">
                <button class="Noto btn btn-outline-dark w-100" @click="$router.push('/login/staff')">
                  <i class="fa-solid fa-briefcase" style="font-size: 50px"></i>
                  <p class="mb-0">Admin</p>
                  <p class="mb-0">เจ้าหน้าที่</p>
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>


<script>
import AlertBox from "./AlertBox.vue";

export default {
  components: {
    AlertBox,
  },
  data() {
    return {};
  },
  methods: {
    async postSessionSave(email) {
      try {
        const response = await fetch(
          `${process.env.VUE_APP_API_BASE_URL}/session/login/save/session`,
          {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ email: email }),
            credentials: "include", // Ensure cookies are included
          }
        );

        if (response.ok) {
          const res = await response.json();
          this.$refs.alertBox.showAlert(res.message, "success");
          if (res.role == "user") {
            this.$router.push("/user");
          } else {
            this.$router.push("/staff");
          }
        } else if (response.status === 500) {
          const errorMessage = await response.text();
          throw new Error(errorMessage);
        } else {
          throw new Error("Connection error");
        }
      } catch (error) {
        console.error(error.message);
        // Safely call showAlert if alertBox exists
        if (this.$refs.alertBox) {
          this.$refs.alertBox.showAlert(error.message, "error");
        }
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
        if (this.alertBox) {
          this.$refs.alertBox.showAlert("เข้าสู้ระบบไม่สำเร็จ", "error");
        }
        return;
      }
      const userInfo = JSON.parse(atob(response.credential.split(".")[1]));
      // const ID = email.match(/^(\d+)(?=@)/);
      this.postSessionSave(userInfo.email);
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
  src: url("@/assets/fonts/Noto_Sans_Thai/NotoSansThai-VariableFont_wdth,wght.ttf") format("truetype");
  font-weight: normal;
  font-style: normal;
  font-display: swap;
}

.Noto {
  font-family: "Noto Sans Thai", sans-serif;
}

@media (max-width: 768px) {}
</style>
