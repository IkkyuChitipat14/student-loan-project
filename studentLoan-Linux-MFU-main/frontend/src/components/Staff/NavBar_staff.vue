<template>
  <nav class="navbar navbar-light bg-white p-0 position-fixed w-100 z-3">
    <ul class="navbar-nav w-100" style="background-color: #964040">
      <div class="row">
        <div class="col d-flex justify-content-start align-items-center">
          <div class="row">
            <div class="col-auto" id="mfu_logo">
              <img
                src="../../assets/mfu_icon.png"
                alt=""
                style="width: 1.4rem; margin-left: 5px"
              />
            </div>
            <div class="col-auto position-relative">
              <div class="d-flex align-items-center h-100">
                <div class="my-auto me-3">
                  <li class="nav-item text-center" @click="staff_home_btn">
                    <a
                      class="nav-link nav-text d-flex align-items-center"
                      href="#"
                    >
                      <p class="m-0 nav-text text-white" id="home_text">
                        หน้าหลัก
                      </p>
                      <i
                        class="fa-solid fa-home pb-1 text-white"
                        id="home_text_sm"
                      ></i>
                    </a>
                  </li>
                </div>
                <div class="my-auto me-3">
                  <li class="nav-item text-center" @click="staff_setting_btn">
                    <a
                      class="nav-link nav-text d-flex align-items-center"
                      href="#"
                    >
                      <p class="m-0 nav-text text-white"  id="setting_text">ตั้งค่าระบบ</p>
                      <i
                        class="fa-solid fa-gear pb-1 text-white"
                        id="setting_text_sm"
                      ></i>
                    </a>
                  </li>
                </div>
                <div class="my-auto">
                  <li class="nav-item text-center" @click="staff_userCheck_btn">
                    <a
                      class="nav-link nav-text d-flex align-items-center"
                      href="#"
                    >
                      <p class="m-0 nav-text text-white loan_check_text">
                        ตรวจสอบ
                      </p>
                      <p class="m-0 nav-text text-white">ผู้ที่ไม่กู้ยืม</p>
                    </a>
                  </li>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="col-auto py-2 d-flex text-end align-items-center float-end">
          <div class="dropdown flex-fill me-3">
            <button
              class="btn btn-link rounded-0 dropdown-toggle text-decoration-none text-white logout-button d-flex align-items-center justify-content-center"
              type="button"
              id="dropdownMenuButton"
              data-bs-toggle="dropdown"
              aria-expanded="false"
            >
              <div id="user_id">
                {{ staffID }}
              </div>
              <div>
                <i class="fa-solid fa-user" id="user_icon"></i>
              </div>
            </button>
            <ul
              class="dropdown-menu dropdown-menu-end"
              aria-labelledby="dropdownMenuButton"
            >
              <li id="user_id_sm">
                <p class="px-3 my-0">{{ staffID }}</p>
                <hr class="m-0 p-0 my-2" />
              </li>
              <li>
                <button
                  class="btn btn-link p-0 ps-3 text-decoration-none text-black"
                  @click="logout_btn"
                >
                  ออกจากระบบ
                </button>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </ul>
  </nav>
</template>

<script>
export default {
  data() {
    return {
      staffID: "-",
    };
  },
  name: "StaffNavbar",
  props: {
    msg: String,
  },

  methods: {
    staff_home_btn() {
      this.$router.push("/staff");
    },
    staff_setting_btn() {
      this.$router.push("/staff/setting");
    },
    staff_userCheck_btn() {
      this.$router.push("/staff/check/user");
    },
    logout_btn() {
      this.logOut();
    },

    async logOut() {
      try {
        const response = await fetch(
          `${process.env.VUE_APP_API_BASE_URL}/session/logout`,
          {
            method: "GET",
            credentials: "include",
          }
        );

        if (response.ok) {
          const Response = await response.json();
          console.log(Response);
          this.$router.push("/login");
        } else {
          throw new Error("Logout failed");
        }
      } catch (error) {
        console.error(error.message);
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
          if (session.role != "staff") {
            this.$router.push("/login");
          }
          this.staffID = session.userID;
        } else if (response.status === 401) {
          // No session found, redirect to login page
          this.logOut();
          throw new Error("No session found. Redirecting to login.");
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
  },
  mounted() {
    this.getSession();
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.nav-link,
.nav-item {
  padding: 0;
  height: 100%;
  min-height: 3.5vh;
}

.nav-item:not(:last-child) {
  border-right: 2px solid #fff;
}

.nav-text {
  font-size: 1rem;
  color: white;
}

.navbar {
  min-height: 3.5vh;
  background-color: #8b0000;
}

.logout-button {
  padding-left: 15px;
  border-left: 1px solid white;
  color: white;
}

.dropdown {
  position: relative;
  z-index: 100;
}

.dropdown-menu {
  position: absolute;
  z-index: 101;
}
#user_icon {
  display: none;
}

#user_id_sm {
  display: none;
}

#home_text_sm {
  display: none;
}

#setting_text_sm {
    display: none;
}


@media (max-width: 550px) {
  #user_id {
    display: none;
  }
  #user_icon {
    display: block;
  }

  #user_id_sm {
    display: block;
  }

  #home_text {
    display: none;
  }

  #home_text_sm {
    display: block;
  }

  #setting_text {
    display: none;
  }

  #setting_text_sm {
    display: block;
    padding: 0 5px;
  }

  .loan_check_text {
    display: none;
  }

  #loan_text-lg {
    display: none;
  }
}

@media (max-width: 350px) {
  #mfu_logo {
    display: none;
  }

  #home_text_sm {
    padding-left: 15px;
  }
}
</style>
