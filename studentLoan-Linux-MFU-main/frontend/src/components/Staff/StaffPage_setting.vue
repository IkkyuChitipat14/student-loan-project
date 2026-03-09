<template>
  <div>
    <!-- Navbar ของ Staff -->
    <StaffNavbar />
    <div>
      <header class="header">
        <h1>ตั้งค่าระบบ</h1>
      </header>
      <div class="container-fluid">
        <div class="py-1 px-5">
          <div class="bg-secondary-light mb-3">
            <!-- สถานะของระบบปัจจุบัน -->
            <div style="background-color: #964040" class="p-3">
              <span>
                <h4 class="text-white my-0">สถานะของระบบ</h4>
              </span>
            </div>
            <!-- แสดงสถานะปัจจุบัน -->
            <div class="status-container">
              <div
                :class="{
                  'status-open': isSystemOpen,
                  'status-closed': !isSystemOpen,
                }"
              >
                <strong>สถานะของระบบ:</strong>
                {{ isSystemOpen ? "เปิดใช้งาน" : "ปิดใช้งาน" }}
              </div>
            </div>
            <!-- แสดงวันเวลาที่ตั้ง Auto -->
            <div class="auto-status">
              <p>
                <strong>ระบบ Auto ตั้งค่าไว้:</strong> เปิดวันที่
                {{ formatDate(autoStartDate) }} ถึง
                {{ formatDate(autoEndDate) }}
                <br />
                ปีการศึกษา {{ studyYear }}
              </p>
            </div>

            <!-- ปุ่มเปิด/ปิด Manual -->
            <div style="background-color: #964040" class="p-3">
              <span>
                <h4 class="text-white my-0">การปิดระบบ (manual)</h4>
              </span>
            </div>
            <div class="radio-container">
              <div class="d-flex align-items-center">
                <input
                  type="radio"
                  id="closeSystem"
                  v-model="systemStatus"
                  value="close"
                  @change="updateSystemStatus('close')"
                  class="radio-button"
                />
                <label for="closeSystem">ปิดระบบ</label>
              </div>
            </div>

            <!-- ตั้งค่า Auto -->
            <div style="background-color: #964040" class="p-3">
              <span>
                <h4 class="text-white my-0">การเปิด-ปิดระบบ (auto)</h4>
              </span>
            </div>
            <div class="form-group ml-3">
              <div class="row mb-3">
                <!-- กล่องเลือกวันเปิดระบบ -->
                <div class="col-auto mb-2">
                  <label for="autoStartDate">เลือกวันเปิดระบบ:</label>
                  <input
                    type="date"
                    id="autoStartDate"
                    v-model="autoStartDate"
                    class="date-input"
                  />
                </div>

                <!-- กล่องเลือกวันปิดระบบ -->
                <div class="col-md-auto">
                  <label for="autoEndDate">เลือกวันปิดระบบ:</label>
                  <input
                    type="date"
                    id="autoEndDate"
                    v-model="autoEndDate"
                    class="date-input"
                  />
                </div>
                <!-- กล่องเลือกปีการศึกษา  -->
              </div>

              <div class="studyYear-box">
                <label for="studyYear">เลือกปีการศึกษา:</label>
                <div class="mb-3">
                  <input
                    type="number"
                    id="studyYear"
                    v-model="studyYear"
                    class="form-control"
                    @input="validateNumber"
                    @keydown.prevent="blockNegative"
                  />
                </div>
                <label for="studySemester">เลือกภาคเรียนการศึกษา:</label>

                <select
                  name="studySemester"
                  id="studySemester"
                  class="form-control"
                  v-model="studySemester"
                  style="width: 150px"
                >
                  <option value="1" selected>1</option>
                  <option value="2">2</option>
                  <option value="3">3</option>
                </select>
              </div>
              <br />
              <!-- ปุ่มบันทึก -->
              <button
                @click="updateAutoSystem"
                class="btn btn-success"
                :disabled="isSystemOpen"
              >
                เปิดระบบ
              </button>
            </div>
          </div>
        </div>
      </div>

       <header class="text-center">
        <h1>ตั้งค่าระบบสำหรับการแก้ไขคำร้อง</h1>
      </header>
      <div class="container-fluid">
        <div class="py-1 px-5">
          <div class="bg-secondary-light mb-3">
            <!-- สถานะของระบบปัจจุบัน -->
            <div style="background-color: #964040" class="p-3">
              <span>
                <h4 class="text-white my-0">สถานะของระบบสำหรับการแก้ไขคำร้อง</h4>
              </span>
            </div>
            <!-- แสดงสถานะปัจจุบัน -->
            <div class="status-container">
              <div
                :class="{
                  'status-open': isSystemOpen_editLoan,
                  'status-closed': !isSystemOpen_editLoan,
                }"
              >
                <strong>สถานะของระบบ:</strong>
                {{ isSystemOpen_editLoan ? "เปิดใช้งาน" : "ปิดใช้งาน" }}
              </div>
            </div>
            <!-- แสดงวันเวลาที่ตั้ง Auto -->
            <div class="auto-status">
              <p>
                <strong>ระบบ Auto ตั้งค่าไว้:</strong> เปิดวันที่
                {{ formatDate(autoStartDate_editLoan) }} ถึง
                {{ formatDate(autoEndDate_editLoan) }}
                <br />
                ปีการศึกษา {{ studyYear_editLoan }}
              </p>
            </div>

            <!-- ปุ่มเปิด/ปิด Manual -->
            <div style="background-color: #964040" class="p-3">
              <span>
                <h4 class="text-white my-0">การปิดระบบ (manual)</h4>
              </span>
            </div>
            <div class="radio-container">
              <div>
                <input
                  type="radio"
                  id="closeSystem_editLoan"
                  v-model="systemStatus_editLoan"
                  value="close"
                  @change="updateSystemStatus_editLoan('close')"
                  class="form-check-input radio-button"
                />
                <label for="closeSystem_editLoan" class="m-0">ปิดระบบ</label>
              </div>
            </div>

            <!-- ตั้งค่า Auto -->
            <div style="background-color: #964040" class="p-3">
              <span>
                <h4 class="text-white my-0">การเปิด-ปิดระบบ (auto)</h4>
              </span>
            </div>
            <div class="form-group ml-3">
              <div class="row mb-3">
                <!-- กล่องเลือกวันเปิดระบบ -->
                <div class="col-auto mb-2">
                  <label for="autoStartDate_editLoan">เลือกวันเปิดระบบ:</label>
                  <input
                    type="date"
                    id="autoStartDate_editLoan"
                    v-model="autoStartDate_editLoan"
                    class="date-input"
                  />
                </div>

                <!-- กล่องเลือกวันปิดระบบ -->
                <div class="col-md-auto">
                  <label for="autoEndDate_editLoan">เลือกวันปิดระบบ:</label>
                  <input
                    type="date"
                    id="autoEndDate_editLoan"
                    v-model="autoEndDate_editLoan"
                    class="date-input"
                  />
                </div>
                <!-- กล่องเลือกปีการศึกษา  -->
              </div>

              <div class="studyYear-box">
                <label for="studyYear_editLoan">เลือกปีการศึกษา:</label>
                <div class="mb-3">
                  <input
                    type="number"
                    id="studyYear_editLoan"
                    v-model="studyYear_editLoan"
                    class="form-control"
                    @input="validateNumber"
                    @keydown.prevent="blockNegative"
                  />
                </div>
                <label for="studySemester_editLoan">เลือกภาคเรียนการศึกษา:</label>

                <select
                  name="studySemester_editLoan"
                  id="studySemester_editLoan"
                  class="form-control"
                  v-model="studySemester_editLoan"
                  style="width: 150px"
                >
                  <option value="1" selected>1</option>
                  <option value="2">2</option>
                  <option value="3">3</option>
                </select>
              </div>
              <br />
              <!-- ปุ่มบันทึก -->
              <button
                @click="updateAutoSystem_editLoan"
                class="btn btn-success"
                :disabled="isSystemOpen_editLoan"
              >
                เปิดระบบ
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import StaffNavbar from "./NavBar_staff.vue";

export default {
  name: "StaffPageSetting",
  components: {
    StaffNavbar,
  },
  data() {
    return {
      isSystemOpen: false,
      systemStatus: "close",
      systemMode: "manual",
      autoStartDate: "",
      autoEndDate: "",
      studyYear: new Date().getFullYear() + 543,
      studySemester: null,

      isSystemOpen_editLoan: false,
      systemStatus_editLoan: "close",
      autoStartDate_editLoan: "",
      autoEndDate_editLoan: "",
      studyYear_editLoan: new Date().getFullYear() + 543,
      studySemester_editLoan: null,
    };
  },
  created() {
    this.fetchSystemStatus();
    this.fetchSystemStatus_editLoan();
  },
  methods: {
    fetchSystemStatus() {
      fetch(
        `${process.env.VUE_APP_API_BASE_URL}/staff/get/system_status?` +
          new Date().getTime(),
        {
          method: "GET",
          headers: { "Content-Type": "application/json" },
          credentials: "include",
        }
      )
        .then((response) => response.json())
        .then((data) => {
          this.isSystemOpen = data.status === "open";
          this.systemStatus = data.status;
          this.systemMode = data.mode;
          this.autoStartDate = data.autoOpenDate || "";
          this.autoEndDate = data.autoCloseDate || "";
          this.studyYear = data.study_year;
          this.studySemester = data.study_semester;
        })
        .catch((error) =>
          console.error("Error fetching system status:", error)
        );
    },
    updateSystemStatus(status) {
      fetch(`${process.env.VUE_APP_API_BASE_URL}/staff/update/system_status`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        credentials: "include",
        body: JSON.stringify({ status: status }),
      })
        .then((response) => response.json())
        .then((data) => {
          alert(data.message);
          setTimeout(() => {
            this.fetchSystemStatus();
          }, 500);
        })
        .catch((error) =>
          console.error("Error updating system status:", error)
        );
    },
    updateAutoSystem() {
      fetch(`${process.env.VUE_APP_API_BASE_URL}/staff/update/system_auto`, {
        method: "POST",
        credentials: "include",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          startDate: this.autoStartDate,
          endDate: this.autoEndDate,
          studyYear: this.studyYear,
          studySemester: this.studySemester,
        }),
      })
        .then((response) => response.json())
        .then((data) => {
          alert(data.message);
          setTimeout(() => {
            this.fetchSystemStatus();
          }, 500);
        })
        .catch((error) => console.error("Error updating auto system:", error));
    },
    formatDate(dateString) {
      if (!dateString) return "-";
      const date = new Date(dateString);
      return date.toLocaleDateString("th-TH", {
        year: "numeric",
        month: "long",
        day: "numeric",
      });
    },

    fetchSystemStatus_editLoan() {
      fetch(
        `${process.env.VUE_APP_API_BASE_URL}/staff/get/system_status/editLoan?` +
          new Date().getTime(),
        {
          method: "GET",
          headers: { "Content-Type": "application/json" },
          credentials: "include",
        }
      )
        .then((response) => response.json())
        .then((data) => {
          console.log(data);
          this.isSystemOpen_editLoan = data.status === "open";
          this.systemStatus_editLoan = data.status;
          this.systemMode_editLoan = data.mode;
          this.autoStartDate_editLoan = data.autoOpenDate || "";
          this.autoEndDate_editLoan = data.autoCloseDate || "";
          this.studyYear_editLoan = data.study_year;
          this.studySemester_editLoan = data.study_semester;
        })
        .catch((error) =>
          console.error("Error fetching system status:", error)
        );
    },
    updateSystemStatus_editLoan(status) {
      fetch(`${process.env.VUE_APP_API_BASE_URL}/staff/update/system_status/editLoan`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        credentials: "include",
        body: JSON.stringify({ status: status }),
      })
        .then((response) => response.json())
        .then((data) => {
          alert(data.message);
          setTimeout(() => {
            this.fetchSystemStatus_editLoan();
          }, 500);
        })
        .catch((error) =>
          console.error("Error updating system status:", error)
        );
    },
    updateAutoSystem_editLoan() {
      fetch(`${process.env.VUE_APP_API_BASE_URL}/staff/update/system_auto/editLoan`, {
        method: "POST",
        credentials: "include",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          startDate: this.autoStartDate_editLoan,
          endDate: this.autoEndDate_editLoan,
          studyYear: this.studyYear_editLoan,
          studySemester: this.studySemester_editLoan,
        }),
      })
        .then((response) => response.json())
        .then((data) => {
          alert(data.message);
          setTimeout(() => {
            this.fetchSystemStatus_editLoan();
          }, 500);
        })
        .catch((error) => console.error("Error updating auto system:", error));
    },

    validateNumber() {
      // Ensure the value is a positive integer and remove invalid characters
      this.studyYear = this.studyYear
        ? this.studyYear.toString().replace(/\D/g, "")
        : "";

      // Prevent leading zeros
      if (this.studyYear.startsWith("0")) {
        this.studyYear = this.studyYear.replace(/^0+/, "");
      }
    },
    blockNegative(event) {
      // Prevent typing '-' and 'e' (in some browsers)
      if (event.key === "-" || event.key === "e") {
        event.preventDefault();
      }
    },
  },
};
</script>

<style scoped>
.status-open {
  color: green;
  font-weight: bold;
}

.status-closed {
  color: red;
  font-weight: bold;
}

.header {
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 80px 0 0 0;
  text-align: center;
}

.bg-secondary-light {
  background-color: rgba(108, 117, 125, 0.2);
}

input {
  outline: none;
  border: 1px solid #ccc;
  padding: 8px;
  border-radius: 5px;
  width: 150px;
}

label {
  font-size: 14px;
  margin-bottom: 4px;
}

.form-group {
  margin-bottom: 20px;
  padding: 15px 0 15px 0;
}

.d-flex {
  display: flex;
  align-items: center;
}

.mx-2 {
  margin-left: 10px;
  margin-right: 10px;
}

.mr-3 {
  margin-right: 20px;
}

.ml-3 {
  margin-left: 15px;
}

.mt-3 {
  margin-top: 20px;
}

.custom-button:hover {
  background-color: #218838;
}

.status-container {
  text-align: left;
  margin-left: 20px;
  font-size: 16px;
  font-weight: bold;
  margin-top: 10px;
  margin-bottom: 10px;
}

.radio-container {
  display: flex;
  align-items: center;
  margin-left: 20px;
  margin-top: 10px;
  margin-bottom: 10px;
}

.d-flex.align-items-start {
  justify-content: flex-start;
}

.date-input {
  width: 150px;
  text-align: left;
}

.radio-button {
  margin-right: 10px;
  width: 16px;
  height: 16px;
  accent-color: #964040;
}

.auto-status {
  margin-left: 20px;
}
</style>
