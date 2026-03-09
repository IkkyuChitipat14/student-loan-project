<template>
  <div>
    <!-- Navbar ของ Staff -->
    <StaffNavbar />
    <AlertBox ref="alertBox" />
    <div>
      <!-- Header ส่วนบนของหน้าจอ -->
      <header class="header">
        <h1>ตรวจสอบผู้ที่ไม่กู้ยืม</h1>
      </header>
      <div>
        <!-- ส่วนของฟอร์มค้นหาคำขอกู้ยืม -->
        <div class="container-fluid">
          <div class="py-1 px-5">
            <div class="bg-secondary-light mb-3 shadow" id="search_form">
              <div style="background-color: #964040" class="p-3">
                <span class="row">
                  <div class="col-auto">
                    <h4 class="text-white my-0">ตัวช่วยการค้นหา</h4>
                  </div>
                </span>
              </div>
              <div class="m-2">
                <div class="mb-3">
                  <div class="px-3">
                    <div class="col">
                      <!-- ฟิลด์ รหัสนักศึกษา, ชื่อ, นามสกุล -->
                      <div class="row">
                        <div class="col">
                          <label for="student_id">รหัสนักศึกษา</label>
                          <input
                            type="number"
                            id="student_id"
                            class="form-control no-arrows"
                            placeholder="กรอกเลขรหัสนักศึกษา"
                            @wheel.prevent
                            v-model="studentId"
                            @input="filterNumber"
                            @keydown="blockInvalidKeys"
                            maxlength="13"
                          />
                        </div>
                        <div class="col-md">
                          <label for="studyYear">ปีการศึกษา</label>
                          <input
                            type="number"
                            id="studyYear"
                            class="form-control no-arrows"
                            placeholder="กรอกปีการศึกษา"
                            @wheel.prevent
                            @keydown="blockInvalidKeys"
                            v-model="studyYear"
                          />
                        </div>
                        <div class="col-md">
                          <label for="studyYear">ความต้องการที่จะกู้ </label>
                          <select
                            id="wantToLoan"
                            v-model="wantToLoan"
                            class="form-control"
                          >
                            <option value="no">ไม่กู้ยืม</option>
                            <option value="yes">กู้ยืม</option>
                          </select>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <!-- ปุ่มล้างค่า และค้นหา -->
              <div class="px-4 pb-2">
                <button
                  style="background-color: #964040"
                  class="btn text-white"
                  name="search"
                  @click="getSearchUserRejectToloan"
                >
                  ค้นหา
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
      <!-- ส่วนแสดงรายละเอียดคำขอกู้ยืม -->
      <div class="container-fluid screen-control">
        <div class="py-1 px-5">
          <div class="bg-secondary-light shadow">
            <div style="background-color: #964040" class="text-white p-3">
              <h4>ผู้ที่ไม่กู้ยืมเงิน</h4>
              <p class="m-0" id="total_Loan">ทั้งหมด {{ totalUser }} คน</p>
              <div class="pagination-container" v-if="totalUser > itemsPerPage">
                <!-- Previous Button -->
                <button
                  class="btn btn-secondary"
                  @click="prevPage"
                  :disabled="currentPage === 1"
                >
                  ก่อนหน้า
                </button>

                <!-- First Page -->
                <button
                  class="btn m-1"
                  :class="{
                    'btn-info': currentPage === 1,
                    'btn-secondary': currentPage !== 1,
                  }"
                  @click="changePage(1)"
                >
                  1
                </button>

                <!-- Dots Before Middle Pages -->
                <span v-if="currentPage > 4">...</span>

                <!-- Middle Pages (Dynamic Range) -->
                <button
                  v-for="page in dynamicPageRange()"
                  :key="page"
                  class="btn m-1"
                  :class="{
                    'btn-info': currentPage === page,
                    'btn-secondary': currentPage !== page,
                  }"
                  @click="changePage(page)"
                >
                  {{ page }}
                </button>

                <!-- Dots After Middle Pages -->
                <span v-if="currentPage < totalPages() - 3">...</span>

                <!-- Last Page -->
                <button
                  class="btn m-1"
                  :class="{
                    'btn-info': currentPage === totalPages(),
                    'btn-secondary': currentPage !== totalPages(),
                  }"
                  @click="changePage(totalPages())"
                >
                  {{ totalPages() }}
                </button>

                <!-- Next Button -->
                <button
                  class="btn btn-secondary"
                  @click="nextPage"
                  :disabled="currentPage === totalPages()"
                >
                  ถัดไป
                </button>
              </div>
            </div>
            <div class="m-2 px-0">
              <div class="table-responsive p-2">
                <table class="table table-light table-striped table-hover">
                  <thead>
                    <tr class="text-start align-top">
                      <th scope="col">ปีการศึกษา</th>
                      <th scope="col">รหัสนักศึกษา</th>
                      <th scope="col">ความต้องการที่จะกู้</th>
                      <th scope="col">รหัสนักศึกษา</th>
                    </tr>
                  </thead>
                  <tbody id="result_table" v-html="result_print"></tbody>
                </table>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import StaffNavbar from "./NavBar_staff.vue";
import Swal from "sweetalert2";
import AlertBox from "../AlertBox.vue";

export default {
  name: "StaffPage_userCheck",
  components: {
    // เอา หน้าอื่นมาใช้
    StaffNavbar,
    AlertBox,
  },

  data() {
    return {
      // เก็บค่าที่ผู้ใช้ป้อน
      studentId: null,
      result_print: "",
      staffEmail: "",
      totalUser: "",
      wantToLoan: "no",
      isUp: true,
      allLoans: [], // เก็บข้อมูลทั้งหมด
      currentPage: 1, // หน้าปัจจุบัน
      itemsPerPage: 50, // จำนวนรายการต่อหน้า

      studyYear: new Date().getFullYear() + 543,
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
          return session;
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

    filterNumber(event) {
      // ตรวจสอบและลบตัวอักษรที่ไม่ใช่ตัวเลข
      const value = event.target.value.replace(/[^0-9]/g, ""); // ลบสิ่งที่ไม่ใช่ตัวเลข
      this.studentId = value.slice(0, 10); // จำกัดความยาวไม่เกิน 10
    },

    blockInvalidKeys(event) {
      // ปิดการทำงานของ e, +, และ -
      if (["e", "E", "+", "-"].includes(event.key)) {
        event.preventDefault();
      }
    },
    toggleArrow() {
      this.isUp = !this.isUp;
    },

    result_show(value) {
      this.allLoans = value;
      this.currentPage = 1;
      this.updatePagination();
    },

    updatePagination() {
      let start = (this.currentPage - 1) * this.itemsPerPage;
      let end = start + this.itemsPerPage;
      let paginatedData = this.allLoans.slice(start, end);
      this.result_print = "";
      this.totalUser = this.allLoans.length;

      // Generating visible pages (1, 2, 3, ..., 8, ...)
      this.visiblePages = this.calculateVisiblePages();

      paginatedData.forEach((uld) => {
        this.result_print += `<tr>`;
        this.result_print += `<td>${uld.user_studyYear}</td>`;
        this.result_print += `<td>${uld.student_id}</td>`;
        this.result_print += `<td>${
          uld.want_to_loan === "yes" ? "กู้ยืม" : "ไม่กู้ยืม"
        }</td>`;
        this.result_print += `<td><button class="btn border-0" id="btn-${uld.student_id}"><i class="fa-solid fa-pen-to-square" style="color: #964040;"></i></button></td>`;

        this.result_print += `</tr>`;
      });

      this.$nextTick(() => {
        paginatedData.forEach((uld) => {
          const button = document.getElementById(`btn-${uld.student_id}`);

          if (button) {
            button.addEventListener("click", () => {
              Swal.fire({
                title: `คุณแน่ใจหรือไม่`,
                html: `
    <div style="text-align: left; max-width: 100%; box-sizing: border-box;">
      <p style="margin-bottom: 1rem; word-wrap: break-word;">
        คุณยืนยันที่จะเปลี่ยนข้อมูลของนักศึกษา <b>${uld.student_id}</b> หรือไม่
      </p>
      <div class="d-flex mt-2 text-center justify-content-center align-items-center">
        <label for="loan-select" class="d-block me-2 mb-2 fw-bold">
          ความต้องการที่จะกู้:
        </label>
        <select id="loan-select" class="form-control w-25">
          <option value="yes">กู้ยืม</option>
          <option value="no">ไม่กู้ยืม</option>
        </select>
      </div>
    </div>
  `,
                showCancelButton: true,
                cancelButtonText: "ยกเลิก",
                confirmButtonText: "ยืนยัน",
                confirmButtonColor: "#964040",
                preConfirm: () => {
                  const select = document.getElementById("loan-select");
                  return select.value;
                },
              }).then((result) => {
                if (result.isConfirmed && result.value) {
                  const selectedValue = result.value;
                  this.patchUserRejectToloan(uld.student_id, selectedValue);
                }
              });
            });
          }
        });
      });
    },

    // Calculate visible pages with ellipsis
    calculateVisiblePages() {
      const totalPages = this.totalPages();
      const maxVisiblePages = 5; // maximum number of visible pages (e.g., 1, 2, 3, ... 8)
      let pages = [];

      if (totalPages <= maxVisiblePages) {
        pages = Array.from({ length: totalPages }, (_, i) => i + 1);
      } else {
        pages = [1, 2, "...", totalPages - 1, totalPages];
      }

      return pages;
    },

    dynamicPageRange() {
      let total = this.totalPages();
      let range = [];

      if (total <= 7) {
        // If total pages are 7 or less, show all pages
        for (let i = 2; i < total; i++) {
          range.push(i);
        }
      } else {
        if (this.currentPage <= 4) {
          // Show first few pages if current page is in the beginning
          range = [2, 3, 4, 5];
        } else if (this.currentPage >= total - 3) {
          // Show last few pages if near the end
          range = [total - 4, total - 3, total - 2, total - 1];
        } else {
          // Show current page in the center with 2 surrounding pages
          range = [
            this.currentPage - 1,
            this.currentPage,
            this.currentPage + 1,
          ];
        }
      }

      return range;
    },

    changePage(page) {
      if (page !== "...") {
        this.currentPage = page;
        this.updatePagination();
      }
    },

    prevPage() {
      if (this.currentPage > 1) {
        this.currentPage--;
        this.updatePagination();
      }
    },

    nextPage() {
      let totalPages = this.totalPages();
      if (this.currentPage < totalPages) {
        this.currentPage++;
        this.updatePagination();
      }
    },

    totalPages() {
      return Math.ceil(this.allLoans.length / this.itemsPerPage);
    },

    async patchUserRejectToloan(ID, value) {
      try {
        const response = await fetch(
          `${process.env.VUE_APP_API_BASE_URL}/staff/reject/update/user`,
          {
            method: "PATCH",
            credentials: "include",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ studentID: ID, value: value }),
          }
        );

        if (response.ok) {
          const staticData = await response.json();
          this.$refs.alertBox.showAlert(staticData.message, "success");
          this.getSearchUserRejectToloan();
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

    async getSearchUserRejectToloan() {
      try {
        const query = new URLSearchParams({
          studentID: this.studentId,
          studyYear: this.studyYear,
          wantToLoan: this.wantToLoan,
        });

        const response = await fetch(
          `${
            process.env.VUE_APP_API_BASE_URL
          }/staff/reject/search/user?${query.toString()}`,
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
  },

  mounted() {
    this.getSession();
    this.getSearchUserRejectToloan();
  },
};
</script>

<style scoped>
.header {
  display: flex;
  align-items: center;
  padding: 80px 0 0 0;
}

img {
  width: 100px;
  height: 150px;
}

h1 {
  margin: 0;
  flex-grow: 0.9;
  text-align: center;
}

.waiting-btn {
  background-color: #964040;
  color: white;
  border: none;
  padding: 10px 20px;
  font-size: 16px;
  cursor: pointer;
  border-radius: 5px;
  transition: background-color 0.3s;
  margin-left: 65px;
}

.verified-btn {
  background-color: grey;
  color: black;
  border: none;
  padding: 10px 20px;
  font-size: 16px;
  cursor: pointer;
  margin: 10px;
  border-radius: 5px;
  transition: background-color 0.3s;
}

.verified-btn:hover {
  background-color: #45a049;
}

.py-5 {
  padding-top: 3rem;
  padding-bottom: 3rem;
}

.px-5 {
  padding-left: 3rem;
  padding-right: 3rem;
}

h2 {
  margin-left: 25px;
}

.bg-secondary-light {
  background-color: rgba(108, 117, 125, 0.2);
}

.d-flex {
  gap: 20px;
}

/* สร้าง class สำหรับพื้นหลังสีเหลือง */
.bg-warning {
  background-color: yellow;
}

.no-arrows::-webkit-inner-spin-button,
.no-arrows::-webkit-outer-spin-button {
  -webkit-appearance: none;
  margin: 0;
}

/* สำหรับ Firefox */
.no-arrows {
  -moz-appearance: textfield;
}

.table-responsive {
  overflow-x: auto;
  overflow-y: hidden;
  width: 100%;
}
</style>
