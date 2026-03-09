<template>
  <div>
    <NavBar :studentID="studentID" />
    <!-- UserPage content here -->
  </div>
  <div class="container-fluid screen-control">
    <div class="py-3">
      <div class="py-5">
        <!-- ข้อมูลเบื้องต้น -->
        <div class="m-2 bg-white px-0 shadow">
          <div
            class="con-header p-3 d-flex justify-content-between align-items-center"
          >
            <h5 class="mb-0">ข้อมูลเบื้องต้น</h5>
          </div>
          <div class="con-content bg-body-secondary">
            <div class="scrollable-content">
              <ul class="p-2">
                <li class="row">
                  <p class="col-auto"><b>อีเมล</b></p>
                  <p class="col">{{ studentID }}@lamduan.mfu.ac.th</p>
                </li>
                <li class="row">
                  <p class="col-auto"><b>รหัสนักศึกษา</b></p>
                  <p class="col">{{ studentID }}</p>
                </li>
              </ul>
            </div>
          </div>
        </div>

        <!-- สถานะการกู้ -->
        <div class="m-2 bg-body-secondary px-0 shadow">
          <div class="con-header p-3">
            <h5>สถานะการกู้</h5>
          </div>
          <div class="table-responsive">
            <table class="table table-secondary">
              <thead>
                <tr class="text-start align-top">
                  <th scope="col">วันที่ยื่นคำขอ</th>
                  <th scope="col">ระดับการศึกษา</th>
                  <th scope="col">ชั้นปี/ภาคเรียน</th>
                  <th scope="col">คณะ/ประเภทวิชา/<br />แผนการเรียน</th>
                  <th scope="col">สาขา/สาขางาน/หลักสูตร</th>
                  <th scope="col">สถานะคำขอ/สถานะสัญญา</th>
                  <th scope="col">รายละเอียดเพิ่มเติม</th>
                  <th scope="col"></th>
                </tr>
              </thead>
              <tbody
                id="result_table"
                v-html="result_print"
                class="text-start align-top"
              ></tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import NavBar from "@/components/User/NavBar_user.vue";
import Swal from "sweetalert2";
import { throttle } from "lodash";

export default {
  name: "UserPage_home",
  components: {
    NavBar,
  },

  data() {
    return {
      studentID: "6531501999",
      result_print: "",
      timeoutId: null, // Add timeoutId for session timeout
      timeoutInMS: null, // Timeout duration (15 minutes) 15 x 60 x 1000 = 60000
      timeoutWarningId: null,
      warningTimeInMS: null,
      activeTimeouts: [],
    };
  },

  methods: {
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
          this.timeoutInMS = session.timeOut;
          this.warningTimeInMS = parseInt(session.timeOut) * (2 / 3);
          this.startTimer(); // Start timeout timer
          if (session.role != "user") {
            this.$router.push("/login");
          }
          this.getStudentLoan();
          this.studentID = session.userID;
        } else if (response.status === 401) {
          // No session found, redirect to login page
          this.$router.replace("/login");
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

    async getStudentLoan() {
      try {
        // Properly append the query string with a key
        const response = await fetch(
          `${process.env.VUE_APP_API_BASE_URL}/user/get/loan`,
          {
            method: "GET",
            credentials: "include",
          }
        );

        if (response.ok) {
          const staticData = await response.json();
          this.result_show(staticData);
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

    result_show(value) {
      this.result_print = "";
      value.forEach((uld) => {
        this.result_print += `<tr>`;
        this.result_print += `<td>${uld.date}</td>`;
        this.result_print += `<td>${uld.user_lvlStudy}</td>`;
        this.result_print += `<td>ชั้นปีที่ ${uld.user_yearStudy}`;
        this.result_print += `<p class="text-secondary">ภาคเรียนที่ ${uld.user_semesterStudy}</p></td>`;
        this.result_print += `<td>${uld.user_faculty}`;
        // this.result_print += `<p class="text-secondary">${uld.user_fieldStudy}</p></td>`;
        this.result_print += `<td>`;
        this.result_print += `<p>${uld.user_fieldStudy}</p>`;

        this.result_print += `</td>`;
        switch (uld.loan_status) {
          case "อยู่ระหว่างดำเนินการ":
            this.result_print += `<td style="color: orange;">${uld.loan_status}</td>`;
            break;
          case "ผ่านการตรวจสอบคุณสมบัติ":
            this.result_print += `<td class="text-success">${uld.loan_status}</td>`;
            break;
          case "อยู่ระหว่างตรวจสอบคุณสมบัติผู้กู้ยืม":
            this.result_print += `<td class="text-secondary">${uld.loan_status}</td>`;
            break;
          case "รอผลการพิจารณาจากกองทุน กยศ.":
            this.result_print += `<td class="text-warning">${uld.loan_status}</td>`;
            break;
          case "ตีกลับเพื่อแก้เอกสาร":
            this.result_print += `<td class="text-primary"">${uld.loan_status}`;
            if (uld.user_semesterStudy == "1") {
              this.result_print += `
               <button class="btn border-0 m-0 p-0 float-end" id="btn-edit-${uld.public_id}"><i class="fa-solid fa-pen-to-square" style="color: #964040;"></i></button>`;
            }
            this.result_print += `</td>`;
            break;
          case "อนุมัติ":
            this.result_print += `<td style='color: #00cc44;'>${uld.loan_status}</td>`;
            break;
          case "ไม่อนุมัติ":
            this.result_print += `<td class="text-danger">${uld.loan_status}</td>`;
            break;
          case "ดำเนินการเรียบร้อย":
            this.result_print += `<td style="color: blue">${uld.loan_status}</td>`;
            break;
          default:
            break;
        }
        this.result_print += `<td style="max-width: 300px; word-wrap: break-word; white-space: normal;">${
          uld.loan_details ?? "-"
        }</td>`;
        this.result_print += `<td><a class="btn border-0" id="btn-${
          uld.public_id
        }" href="/user/info?id=${
          uld.public_id
        }&ts=${Date.now()}" target="_blank"><i class="fa-solid fa-magnifying-glass" style="color: #964040;"></i></a></td>`;
        this.result_print += `</tr>`;
      });

      this.$nextTick(() => {
        value.forEach((uld) => {
          const button = document.getElementById(`btn-${uld.public_id}`);
          const buttonEdit = document.getElementById(
            `btn-edit-${uld.public_id}`
          );
          if (button) {
            button.addEventListener("click", () => {
              window.open(
                `/user/info?id=${uld.public_id}&ts=${Date.now()}`,
                "_blank"
              );
            });
          }
          if (buttonEdit) {
            buttonEdit.addEventListener("click", () => {
              localStorage.setItem("uldId", uld.public_id);
              this.$router.push("/user/loan");
            });
          }
        });
      });
    },

    // Session Timeout Methods
    handleInactive() {
      this.logOut();
    },

    startTimer() {
      // Set the main timeout
      this.timeoutId = setTimeout(this.handleInactive, this.timeoutInMS);

      // Store the main timeout details
      const timeoutDetails = {
        id: this.timeoutId,
        type: "timeout",
        startTime: Date.now(),
        duration: this.timeoutInMS,
      };
      this.activeTimeouts.push(timeoutDetails);

      // Set the warning timeout
      const warningTimeoutId = setTimeout(
        this.showSessionWarning,
        this.warningTimeInMS
      );

      // Store the warning timeout details
      const warningTimeoutDetails = {
        id: warningTimeoutId,
        type: "warning",
        startTime: Date.now(),
        duration: this.warningTimeInMS,
      };
      this.activeTimeouts.push(warningTimeoutDetails);

      // Store the warning timeout ID
      this.timeoutWarningId = warningTimeoutId;
    },

    showSessionWarning() {
      Swal.fire({
        title: "เตือน",
        text: `เซสชันของคุณจะหมดอายุใน ${Math.round(
          this.warningTimeInMS / 60 / 1000 / 2
        )} นาที!`,
        confirmButtonColor: "grey",
      });
    },

    clearAllTimeouts() {
      this.activeTimeouts.forEach((timeout) => {
        clearTimeout(timeout.id);
      });

      // Empty the array since all timeouts are cleared
      this.activeTimeouts = [];
    },

    async resetSessionExpiration() {
      try {
        const response = await fetch(
          `${process.env.VUE_APP_API_BASE_URL}/session/reset/session`,
          {
            method: "POST",
            credentials: "include", // Ensure cookies are included
          }
        );

        const data = await response.json();
        if (data.success) {
          // Ensure existing timers are cleared before setting new ones
          this.clearAllTimeouts();
          this.getSession();
        }
      } catch (error) {
        console.error("Error extending session:", error);
      }
    },
  },

  //Use function when the component is used
  mounted() {
    this.getSession();
    this.throttledResetSessionExpiration = throttle(
      this.resetSessionExpiration,
      3000
    );
    window.addEventListener("scroll", this.throttledResetSessionExpiration);
  },
  unmounted() {
    window.removeEventListener("scroll", this.throttledResetSessionExpiration);
    this.clearAllTimeouts();
  },
};
</script>

<style scoped>
/* To Make Sure h1-h6 don't have extended space */
h2,
h3,
h4,
h5,
h6 {
  margin: 0;
  padding: 0;
}

.con-header {
  color: white;
  background-color: #964040;
}

.screen-control {
  height: 100vh;
  min-height: 100%;
  padding: 0 5rem;
}

.table-responsive {
  overflow-x: auto;
  overflow-y: hidden;
  width: 100%;
}

.table {
  min-width: 1000px; /* Ensure the table has a minimum width */
}
@media (max-width: 768px) {
  .screen-control {
    height: 100vh;
    min-height: 100%;
    padding: 0;
  }
}
</style>
