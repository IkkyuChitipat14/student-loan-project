<template>
  <nav class="navbar navbar-light bg-white p-0 position-fixed w-100 z-3 shadow">
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
            <div class="col-auto position-relative" style="min-width: 185px">
              <div class="d-flex align-items-center h-100">
                <div class="my-auto">
                  <li class="nav-item text-center" @click="user_home_btn">
                    <a
                      class="nav-link nav-text d-flex align-items-center"
                      href="#"
                    >
                      <p class="m-0 nav-text text-white" id="home_text">
                        หน้าหลัก
                      </p>
                      <i
                        class="fa-solid fa-house pb-1 text-white"
                        id="home_text_sm"
                      ></i>
                    </a>
                  </li>
                </div>
                <div class="mx-4" v-if="Server_Status &&relocate">
                  <li class="nav-item text-center" @click="user_loan_btn">
                    <a
                      class="nav-link nav-text d-flex align-items-center"
                      href="#"
                    >
                      <p class="m-0 nav-text text-white" id="loan_text-lg">
                        การ
                      </p>
                      <p class="m-0 nav-text text-white">ยื่นกู้</p>
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
                {{ studentID }}
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
                <p class="px-3 my-0">{{ studentID }}</p>
                <hr class="m-0 p-0 my-2" />
              </li>
              <li>
                <button
                  class="btn btn-link p-0 ps-3 text-decoration-none text-black"
                  @click="logOut"
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
      Server_Status: true,
      relocate: false,
    };
  },
  name: "NavBar",
  props: {
    studentID: {
      type: String,
      required: true,
      studentID: "6531501999",
      loan: null,
    },
  },

  methods: {
    user_home_btn() {
      this.$router.push("/user");
    },
    user_loan_btn() {
      this.$router.push(`/user/${this.loan}`);
    },
    logout_btn() {
      this.$router.replace("/login");
    },

    async getServerStatus() {
      try {
        // Properly append the query string with a key
        const response = await fetch(
          `${process.env.VUE_APP_API_BASE_URL}/user/loan/server/status`
        );
        if (response.ok) {
          const serverStatus = await response.json();

          if (serverStatus.server_status == "close") {
            return (this.Server_Status = false);
          }
          switch (serverStatus.study_semester) {
            case "1":
              this.loan = "loan";
              this.relocate = true;
              break;
            case "2":
              this.loan = "loan/secondSemester";
              this.relocate = true;
              break;
            default:
              this.loan = "loan";
              this.relocate = true;
              break;
          }
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
  },
  mounted() {
    this.getServerStatus();
  },
};
</script>

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
  color: black;
}

.navbar {
  min-height: 3.5vh;
}

.logout-button {
  padding-left: 15px;
  border-left: 1px solid white;
}

.dropdown {
  position: relative;
  z-index: 1001;
}

.dropdown-menu {
  position: absolute;
  z-index: 1002;
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
@media (max-width: 500px) {
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
