<!-- login แล้วจะมาโผล่หน้านี้ (admin) -->
<template>
  <div>
    <!-- Navbar ของ Staff -->
    <StaffNavbar />
    <AlertBox ref="alertBox" />
    <StaffPageExcel ref="loanModal" />
    <div>
      <!-- Header ส่วนบนของหน้าจอ -->
      <header class="header">
        <h1>ตรวจสอบแบบคำขอกู้ยืมเงิน</h1>
      </header>
      <div>
        <!-- ส่วนของฟอร์มค้นหาคำขอกู้ยืม -->
        <div class="container-fluid">
          <div class="py-1 px-5">
            <div class="bg-secondary-light mb-3 shadow" id="search_form">
              <div style="background-color: #964040" class="p-3">
                <span>
                  <h4 class="text-white my-0">ตัวช่วยการค้นหา</h4>
                </span>
              </div>
              <div class="m-2">
                <div class="mb-5">
                  <div class="px-3">
                    <div class="col">
                      <!-- ฟิลด์ รหัสนักศึกษา, ชื่อ, นามสกุล -->
                      <div class="row mb-3">
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
                        <div class="col-12 col-md">
                          <label for="first_name">ชื่อ</label>
                          <input
                            type="text"
                            id="first_name"
                            class="form-control"
                            placeholder="กรอกชื่อ"
                          />
                        </div>
                        <div class="col">
                          <label for="last_name">นามสกุล</label>
                          <input
                            type="text"
                            id="last_name"
                            class="form-control"
                            placeholder="กรอกนามสกุล"
                          />
                        </div>
                      </div>

                      <!-- ส่วนเลือกระดับการศึกษา, ปีการศึกษา, ภาคเรียน, ชั้นปี -->
                      <div class="row mb-2">
                        <div class="col d-flex flex-wrap">
                          <div class="col">
                            <label>ระดับการศึกษา</label>
                            <select class="form-select" id="graduated_level">
                              <option selected disabled value="">
                                กรุณาเลือก
                              </option>
                              <option value="ปริญญาตรี">ปริญญาตรี</option>
                              <option value="ปริญญาโท">ปริญญาโท</option>
                              <option value="ประกาศนียบัตร">
                                ประกาศนียบัตร
                              </option>
                            </select>
                          </div>
                          <div class="col-12 col-md">
                            <label>ปีการศึกษา</label>
                            <select class="form-select" id="study_year">
                              <option selected disabled value="">
                                กรุณาเลือก
                              </option>
                              <option>2564</option>
                              <option>2565</option>
                              <option>2566</option>
                              <option>2567</option>
                              <option>2568</option>
                              <option>2569</option>
                            </select>
                          </div>
                          <div class="col">
                            <label>ภาคเรียน</label>
                            <select class="form-select" id="study_semester">
                              <option selected disabled value="">
                                กรุณาเลือก
                              </option>
                              <option>1</option>
                              <option>2</option>
                              <option>3</option>
                            </select>
                          </div>
                        </div>
                      </div>
                      <!-- ส่วนเลือกวันที่ยื่นคำขอ -->
                      <div class="col mt-3">
                        <label for="user_startSemesterStudy"
                          >วันที่ยื่นคำขอ</label
                        >
                        <div class="d-flex align-items-center">
                          <input
                            type="date"
                            class="form-control mr-2"
                            id="submission_date"
                          />
                          <h3 class="mx-2">-</h3>
                          <input
                            type="date"
                            class="form-control"
                            id="submission_date_end"
                          />
                        </div>
                      </div>
                      <div class="col mt-3">
                        <label for="loan_status">สถานะคำขอ/สถานะสัญญา</label>
                        <select class="form-control w-50" id="loan_status">
                          <option value="" selected>ทั้งหมด</option>
                          <option value="ผ่านการตรวจสอบคุณสมบัติ">
                            ผ่านการตรวจสอบคุณสมบัติ
                          </option>
                          <option value="อยู่ระหว่างดำเนินการ">
                            อยู่ระหว่างดำเนินการ
                          </option>
                          <option value="ตีกลับเพื่อแก้เอกสาร">
                            ตีกลับเพื่อแก้เอกสาร
                          </option>
                          <option value="อยู่ระหว่างตรวจสอบคุณสมบัติผู้กู้ยืม">
                            อยู่ระหว่างตรวจสอบคุณสมบัติผู้กู้ยืม
                          </option>

                          <option value="รอผลการพิจารณาจากกองทุน กยศ.">
                            รอผลการพิจารณาจากกองทุน กยศ.
                          </option>
                          <option value="อนุมัติ">อนุมัติ</option>
                          <option value="ไม่อนุมัติ">ไม่อนุมัติ</option>
                        </select>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <!-- ปุ่มล้างค่า และค้นหา -->
              <div class="px-3 pb-3">
                <button
                  class="btn btn-secondary"
                  name="clearValues"
                  @click="clearInput"
                >
                  ล้างค่า
                </button>
                <button
                  style="background-color: #964040"
                  class="btn text-white float-end"
                  name="search"
                  @click="getStudentLoanSearch"
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
              <div class="row">
                <div class="col">
                  <div class="row">
                    <div class="col"><h4>รายละเอียดคำขอกู้ยืมเงิน</h4></div>
                  </div>

                  <div
                    class="d-flex justify-content-start align-items-center my-2"
                  >
                    <p class="m-0">ทั้งหมด</p>
                    <select
                      name="total_loan_number"
                      id="total_loan_number"
                      class="form-select"
                      style="max-width: 100px"
                      v-model="itemsPerPage"
                      @change="handleItemsPerPageChange"
                    >
                      <option value="50">50</option>
                      <option value="100" selected>100</option>
                      <option value="100">200</option>
                    </select>
                    <p class="m-0">รายการ</p>
                  </div>
                </div>

                <!-- checkbox controller -->
                <div
                  class="col text-end align-self-center"
                  v-show="checkedLoans.length > 0"
                >
                  <div>
                    <div
                      class="d-flex justify-content-end align-items-center mb-4"
                    >
                      <p class="my-auto">
                        <b>เลือกแล้ว {{ checkedLoans.length }} รายการ</b>
                      </p>
                      <div>
                        <input
                          type="checkbox"
                          id="checkbox_loan_all"
                          class="form-check-input me-1"
                        />
                        <label for="checkbox_loan_all"
                          ><b>เลือกทั้งหมด</b></label
                        >
                      </div>
                    </div>
                    <div class="d-flex gap-2 justify-content-end">
                      <button
                        class="btn btn-light"
                        @click="openLoanModal"
                        :disabled="isLoading_downLoadButton"
                      >
                        <span
                          v-if="isLoading_downLoadButton"
                          class="spinner-border spinner-border-sm me-2"
                        ></span>
                        <span v-else>ดาวน์โหลดคำขอกู้</span>
                      </button>

                      <button
                        class="btn btn-light"
                        @click="confirmBoxWithValue"
                      >
                        เปลี่ยนสถานะคำข้อกู้
                      </button>
                    </div>
                  </div>
                </div>
              </div>
              <div>
                <div class="row">
                  <div class="col">
                    <div
                      class="pagination-container"
                      v-if="totalLoan > itemsPerPage"
                    >
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
                      <select
                        v-model="currentPage"
                        class="mx-2 px-3 py-2 rounded rounded-3"
                      >
                        <option
                          v-for="page in totalPages()"
                          :key="page"
                          :value="page"
                        >
                          {{ page }}
                        </option>
                      </select>
                    </div>
                  </div>

                  <div class="col">
                    <button
                      @click="getStudentLoanSearch"
                      class="float-end btn border-0"
                      :disabled="isLoading"
                    >
                      <i
                        class="fa-solid fa-rotate-right text-white"
                        :class="{ spin: isLoading }"
                      ></i>
                    </button>
                  </div>
                </div>
              </div>
            </div>

            <div class="m-2 px-0">
              <div class="table-responsive">
                <table class="table table-secondary" style="min-width: 1000px">
                  <thead>
                    <tr class="text-start align-top">
                      <th scope="col">
                        วันที่ยื่นคำขอ
                        <button
                          @click="
                            toggleArrow();
                            getStudentLoanSearch();
                          "
                          class="p-0 border rounded bg-transparent"
                        >
                          <i v-if="isUp" class="fas fa-chevron-up"></i>
                          <i v-else class="fas fa-chevron-down"></i>
                        </button>
                      </th>
                      <th scope="col">รหัสนักศึกษา</th>
                      <th scope="col">ชื่อ-นามสกุล</th>
                      <th scope="col">ระดับการศึกษา</th>
                      <th scope="col">ชั้นปี/ภาคเรียน</th>
                      <th scope="col">คณะ/ประเภทวิชา/แผนการเรียน</th>
                      <th scope="col">สาขา</th>
                      <th scope="col">สถานะคำขอ/สถานะสัญญา</th>
                      <th scope="col">รายละเอียดเพิ่มเติม</th>
                      <th scope="col">ดูแลโดย</th>
                      <th scope="col"></th>
                      <th scope="col"></th>
                      <th scope="col">
                        <div class="col">
                          <div class="row">
                            <label for="select-all-checkbox"
                              >เลือกทั้งหมด</label
                            >
                          </div>
                          <div class="row justify-content-center">
                            <input
                              type="checkbox"
                              id="select-all-checkbox"
                              class="form-check-input p-0"
                            />
                          </div>
                        </div>
                      </th>
                    </tr>
                  </thead>
                  <tbody v-if="isLoading">
                    <tr>
                      <td colspan="14" class="text-center py-4">
                        <div
                          class="spinner-border text-danger"
                          role="status"
                          style="width: 3rem; height: 3rem"
                        >
                          <span class="visually-hidden">Loading...</span>
                        </div>
                        <p class="mt-2">กำลังโหลดข้อมูล...</p>
                      </td>
                    </tr>
                  </tbody>
                  <tbody v-else id="result_table" v-html="result_print"></tbody>
                </table>
              </div>
            </div>

            <div style="background-color: #964040" class="text-white p-3">
              <div class="pagination-container" v-if="totalLoan > itemsPerPage">
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
import StaffPageExcel from "./StaffPage_Excel.vue";

export default {
  name: "StaffPage_home",
  components: {
    // เอา หน้าอื่นมาใช้
    StaffNavbar,
    AlertBox,
    StaffPageExcel,
  },

  data() {
    return {
      // เก็บค่าที่ผู้ใช้ป้อน
      studentId: "",
      result_print: "",
      staffEmail: "",
      totalLoan: 0,
      isUp: true,
      allLoans: [], // เก็บข้อมูลทั้งหมด
      currentPage: 1, // หน้าปัจจุบัน
      itemsPerPage: 100, // จำนวนรายการต่อหน้า
      checkedLoans: [], // เก็บรายการที่ถูกเลือก
      isLoading: false, // ใช้สำหรับแสดงสถานะการโหลด
      isLoading_downLoadButton: false,
    };
  },
  methods: {
    async openLoanModal() {
      this.isLoading_downLoadButton = true;
      try {
        await this.$refs.loanModal.openModal(this.checkedLoans);
      } catch (err) {
        console.error("Modal failed to open", err);
      } finally {
        this.isLoading_downLoadButton = false;
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
      this.studentId = value.slice(0, 10); // จำกัดความยาวไม่เกิน 13
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
      this.allLoans = value.data;
      this.totalLoan = value.total;
      this.currentPage = 1;
      this.updatePagination();
    },

    handleItemsPerPageChange() {
      this.currentPage = 1;
      this.updatePagination();
    },

    updatePagination() {
      // No slicing needed anymore since the backend sends paginated data
      const startIndex = (this.currentPage - 1) * this.itemsPerPage;
      const endIndex = startIndex + this.itemsPerPage;
      const paginatedData = this.allLoans.slice(startIndex, endIndex);
      const statusClassMap = {
        อยู่ระหว่างดำเนินการ: "style='color: orange;'",
        ผ่านการตรวจสอบคุณสมบัติ: "class='text-success'",
        อยู่ระหว่างตรวจสอบคุณสมบัติผู้กู้ยืม: "class='text-secondary'",
        "รอผลการพิจารณาจากกองทุน กยศ.": "class='text-warning'",
        ตีกลับเพื่อแก้เอกสาร: "class='text-primary'",
        อนุมัติ: "style='color: #00cc44;'",
        ไม่อนุมัติ: "class='text-danger'",
      };

      this.result_print = "";
      document.getElementById("select-all-checkbox").checked = false;

      this.visiblePages = this.calculateVisiblePages();

      paginatedData.forEach((uld) => {
        this.result_print += `<tr>`;
        this.result_print += `<td><p class="m-0">${uld.date}</p><p class="text-secondary">${uld.time}</p></td>`;
        this.result_print += `<td>${uld.user_studentID}</td>`;
        this.result_print += `<td>${uld.user_username} ${uld.user_surname}</td>`;
        this.result_print += `<td>${uld.user_lvlStudy}</td>`;
        this.result_print += `<td style="min-width:100px;">ชั้นปีที่ ${uld.user_yearStudy}<p class="text-secondary">ภาคเรียนที่ ${uld.user_semesterStudy}</p></td>`;
        this.result_print += `<td>${uld.user_faculty}</td>`;
        this.result_print += `<td>${uld.user_fieldStudy}</td>`;

        const loanStatusAttr = statusClassMap[uld.loan_status] || "";
        this.result_print += `<td ${loanStatusAttr}>${uld.loan_status}</td>`;

        this.result_print += `<td style="max-width: 300px; word-wrap: break-word; white-space: normal;">${
          uld.loan_details ?? "-"
        }</td>`;
        this.result_print += `<td style="min-width:100px">${
          uld.managed_by || "-"
        }</td>`;
        this.result_print += `<td><a class="btn border-0" id="btn-${
          uld.public_id
        }" href="/staff/info?id=${
          uld.public_id
        }&ts=${Date.now()}" target="_blank"><i class="fa-solid fa-magnifying-glass" style="color: #964040;"></i></a></td>`;
        this.result_print += `<td><button class="btn border-0" id="btn-delete-${uld.public_id}"><i class="fa-solid fa-trash" style="color: #964040;"></i></button></td>`;
        this.result_print += `<td class="text-center"><input type="checkbox"  type="checkbox" class="form-check-input form-check-select mt-2" mt-2" data-id="${
          uld.public_id
        }" ${this.checkedLoans.includes(uld.public_id) ? "checked" : ""}></td>`;
        this.result_print += `</tr>`;
      });

      this.$nextTick(() => {
        paginatedData.forEach((uld) => {
          const button = document.getElementById(`btn-${uld.public_id}`);
          if (button) {
            button.addEventListener("click", () => {
              window.open(
                `/staff/info?id=${uld.public_id}&ts=${Date.now()}`,
                "_blank"
              );
            });
          }

          const buttonDelete = document.getElementById(
            `btn-delete-${uld.public_id}`
          );
          if (buttonDelete) {
            buttonDelete.addEventListener("click", () => {
              Swal.fire({
                title: "คุณแน่ใจหรือไม่?",
                html: `
                    <p>พิมพ์ <strong>'ฉันต้องการลบข้อมูล'</strong> เพื่อยืนยันการลบคำขอเงินกู้ยืม</p>
                    <input id="swal-input" class="swal2-input" placeholder="ฉันต้องการลบข้อมูล" />
                    <button id="fill-btn" class="swal2-confirm swal2-styled" style="background-color: #666; margin-top: 10px;">
                      กรอกข้อความอัตโนมัติ
                    </button>
                  `,
                icon: "warning",
                showCancelButton: true,
                confirmButtonColor: "#964040",
                cancelButtonColor: "#d33",
                cancelButtonText: "ยกเลิก",
                confirmButtonText: "ใช่, ลบเลย!",
                focusConfirm: false,
                preConfirm: () => {
                  const input = document.getElementById("swal-input").value;
                  if (input !== "ฉันต้องการลบข้อมูล") {
                    Swal.showValidationMessage(
                      "คุณต้องพิมพ์ให้ตรง: ฉันต้องการลบข้อมูล"
                    );
                  }
                  return input;
                },
                didOpen: () => {
                  const fillBtn = document.getElementById("fill-btn");
                  fillBtn.addEventListener("click", () => {
                    document.getElementById("swal-input").value =
                      "ฉันต้องการลบข้อมูล";
                  });
                },
              }).then((result) => {
                if (
                  result.isConfirmed &&
                  result.value === "ฉันต้องการลบข้อมูล"
                ) {
                  this.deleteSystemStatus(uld.public_id);
                }
              });
            });
          }

          const button_pdf = document.getElementById(
            `btn-pdf-${uld.public_id}`
          );
          if (button_pdf) {
            button_pdf.addEventListener("click", () => {
              this.getPDFpersonalData(uld.public_id, uld.user_studentID);
              // alert(uld.public_id);
            });
          }
        });
        const checkboxes = document.querySelectorAll(".form-check-select");
        checkboxes.forEach((checkbox) => {
          const loanId = checkbox.getAttribute("data-id");
          checkbox.addEventListener("change", (e) => {
            if (e.target.checked) {
              if (!this.checkedLoans.includes(loanId)) {
                this.checkedLoans.push(loanId);
              }
            } else {
              this.checkedLoans = this.checkedLoans.filter(
                (id) => id !== loanId
              );
            }
            // 🔄 Update "Select All on This Page" checkbox
            const currentPageIds = Array.from(checkboxes).map((cb) =>
              cb.getAttribute("data-id")
            );
            const allPageChecked = currentPageIds.every((id) =>
              this.checkedLoans.includes(id)
            );
            const selectAllCheckbox = document.getElementById(
              "select-all-checkbox"
            );
            if (selectAllCheckbox) {
              selectAllCheckbox.checked = allPageChecked;
            }
            // 🔄 Update "Select All Across All Pages" checkbox
            const allIds = this.allLoans.map((loan) => loan.public_id);
            const allChecked = allIds.every((id) =>
              this.checkedLoans.includes(id)
            );
            const checkboxLoanAll =
              document.getElementById("checkbox_loan_all");
            if (checkboxLoanAll) {
              checkboxLoanAll.checked = allChecked;
            }
          });
        });
        // Select All Checkbox
        const selectAllCheckbox = document.getElementById(
          "select-all-checkbox"
        );
        if (selectAllCheckbox) {
          selectAllCheckbox.addEventListener("change", (e) => {
            const isChecked = e.target.checked;
            const checkboxes = document.querySelectorAll(".form-check-select");
            const currentPageIds = [];
            checkboxes.forEach((cb) => {
              const id = cb.getAttribute("data-id");
              currentPageIds.push(id);
            });
            if (isChecked) {
              // Add current page's checkboxes to the list
              currentPageIds.forEach((id) => {
                if (!this.checkedLoans.includes(id)) {
                  this.checkedLoans.push(id);
                }
              });
            } else {
              // Remove current page's checkboxes from the list
              this.checkedLoans = this.checkedLoans.filter(
                (id) => !currentPageIds.includes(id)
              );
            }
            checkboxes.forEach((cb) => {
              cb.checked = isChecked;
              const id = cb.getAttribute("data-id");
              if (isChecked && !this.checkedLoans.includes(id)) {
                this.checkedLoans.push(id);
              }
            });
          });
        }

        // Checkbox for "Select All Loans"
        const checkboxLoanAll = document.getElementById("checkbox_loan_all");
        if (checkboxLoanAll) {
          checkboxLoanAll.addEventListener("change", (e) => {
            const isChecked = e.target.checked;
            if (isChecked) {
              // Select all loan IDs from allLoans
              this.checkedLoans = this.allLoans.map((loan) => loan.public_id);
            } else {
              // Deselect all
              this.checkedLoans = [];
            }
            // Re-render current page checkboxes
            const pageCheckboxes =
              document.querySelectorAll(".form-check-select");
            pageCheckboxes.forEach((cb) => {
              const id = cb.getAttribute("data-id");
              if (isChecked && !this.checkedLoans.includes(id)) {
                this.checkedLoans.push(id);
              }
            });

            // Also update per-page select-all checkbox if exists
            const selectAll = document.getElementById("select-all-checkbox");
            if (selectAll) {
              selectAll.checked = isChecked;
            }
            this.updatePagination();
          });
        }

        // check all in that pages handler
        const pageCheckboxes = document.querySelectorAll(".form-check-select");
        const currentPageIds = Array.from(pageCheckboxes).map((cb) =>
          cb.getAttribute("data-id")
        );
        const allPageChecked = currentPageIds.every((id) =>
          this.checkedLoans.includes(id)
        );
        if (selectAllCheckbox) {
          selectAllCheckbox.checked = allPageChecked;
        }
      });
    },

    // Edit Loan Status
    confirmBoxWithValue() {
      Swal.fire({
        title: "เปลี่ยนสถานะ",
        html: `<select id="swal-status" class="swal2-select text-center" style="min-width: 200px;">
        <option value="" disabled selected>-- เลือกสถานะ --</option>
        <option value="อยู่ระหว่างดำเนินการ">อยู่ระหว่างดำเนินการ</option>
        <option value="ผ่านการตรวจสอบคุณสมบัติ">ผ่านการตรวจสอบคุณสมบัติ</option>
        <option value="อยู่ระหว่างตรวจสอบคุณสมบัติผู้กู้ยืม">อยู่ระหว่างตรวจสอบคุณสมบัติผู้กู้ยืม</option>
        <option value="รอผลการพิจารณาจากกองทุน กยศ.">รอผลการพิจารณาจากกองทุน กยศ.</option>
        <option value="ตีกลับเพื่อแก้เอกสาร">ตีกลับเพื่อแก้เอกสาร</option>
        <option value="อนุมัติ">อนุมัติ</option>
        <option value="ไม่อนุมัติ">ไม่อนุมัติ</option>
      </select>
      <textarea id="swal-reason" class="swal2-textarea" placeholder="กรุณากรอกเหตุผล (ไม่เกิน 200 ตัวอักษร)" maxlength="200" style="margin-top: 1em;"></textarea>`,
        focusConfirm: false,
        showCancelButton: true,
        cancelButtonText: "ยกเลิก",
        confirmButtonText: "ยืนยัน",
        confirmButtonColor: "#964040",
        preConfirm: () => {
          const status = document.getElementById("swal-status").value;
          const reason = document.getElementById("swal-reason").value.trim();

          if (!status) {
            Swal.showValidationMessage("กรุณาเลือกสถานะ");
            return false;
          }
          if (reason.length > 200) {
            Swal.showValidationMessage("เหตุผลต้องไม่เกิน 200 ตัวอักษร");
            return false;
          }
          return { status, reason };
        },
      }).then((result) => {
        if (result.isConfirmed) {
          const { status, reason } = result.value;
          this.postBulkEditLoanStatus(this.checkedLoans, status, reason);
        }
      });
    },

    async postBulkEditLoanStatus(idArray, newStatus, reason = "") {
      if (!Array.isArray(idArray) || idArray.length === 0) {
        return this.$refs.alertBox.showAlert("กรุณาเลือกรายการ", "warning");
      }

      const updates = idArray.map((id) => ({
        ID: id,
        newStatus,
        reason,
      }));
      try {
        const response = await fetch(
          `${process.env.VUE_APP_API_BASE_URL}/staff/loan/edit/status/bulk`,
          {
            method: "PATCH",
            credentials: "include",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(updates),
          }
        );

        if (response.ok) {
          const result = await response.json();

          const summaryLines = result.summary.map(
            (s) => `สถานะ: ${s.status} - จำนวน: ${s.changed} รายการ`
          );

          const failureLines = result.failures.map(
            (f) => `ID: ${f.ID} → ${f.reason}`
          );

          const htmlMessage = `
        <strong>📌 ผลการอัปเดตสถานะ</strong><br/>
        ${summaryLines.join("<br/>")}
        ${
          failureLines.length > 0
            ? "<br/><br/><strong>❌ รายการที่ไม่สำเร็จ:</strong><br/>"
            : ""
        }
        ${failureLines.join("<br/>")}
      `;

          await Swal.fire({
            icon: failureLines.length > 0 ? "warning" : "success",
            title: "ผลการอัปเดต",
            html: htmlMessage,
            confirmButtonText: "ปิด",
          });

          this.getStudentLoanSearch(); // Refresh table
          this.checkedLoans = [];
        } else {
          const error = await response.text();
          Swal.fire({
            icon: "error",
            title: "เกิดข้อผิดพลาด",
            text: error,
          });
        }
      } catch (err) {
        console.error(err);
        Swal.fire({
          icon: "error",
          title: "เกิดข้อผิดพลาด",
          text: err.message || "Unknown error",
        });
      }
    },

    // Delete Data
    async deleteSystemStatus(publicId) {
      try {
        const response = await fetch(
          `${process.env.VUE_APP_API_BASE_URL}/staff/delete/loan?public_id=${publicId}`,
          {
            method: "DELETE",
            credentials: "include", // send cookies/session
          }
        );
        const result = await response.json();
        if (response.ok) {
          this.$refs.alertBox?.showAlert(result.message, "success");
          this.checkedLoans = [];
          this.getStudentLoanSearch();
        } else {
          throw new Error(result.error || "Delete failed");
        }
      } catch (error) {
        console.error("Delete error:", error.message);
        this.$refs.alertBox?.showAlert(error.message, "error");
      }
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

        window.scrollTo({
          top: 0,
          behavior: "smooth", // optional for smooth animation
        });
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
      return Math.ceil(this.totalLoan / this.itemsPerPage);
    },

    async getStudentLoanSearch() {
      // const limit = this.itemsPerPage;
      // const offset = (this.currentPage - 1) * this.itemsPerPage;
      this.isLoading = true;
      try {
        // Collect input values
        const allInput = document.querySelectorAll(
          "#search_form input, select"
        );
        let inputDataArray = Array.from(allInput).map((input) => ({
          id: input.id,
          value: input.value,
        }));

        inputDataArray.push({ id: "orderByDate", value: `${this.isUp}` });
        // inputDataArray.push({ id: "limit", value: limit });
        // inputDataArray.push({ id: "offset", value: offset });

        // Convert inputDataArray into a query string
        const queryString = inputDataArray
          .filter((input) => String(input.value).trim() !== "") // Remove empty inputs
          .map(
            (input) =>
              `${encodeURIComponent(input.id)}=${encodeURIComponent(
                input.value
              )}`
          )
          .join("&");

        // Send the query string to the backend
        const response = await fetch(
          `${process.env.VUE_APP_API_BASE_URL}/staff/get/loan/search?${queryString}`,
          {
            credentials: "include",
          }
        );

        if (response.ok) {
          const staticData = await response.json();
          this.checkedLoans = []; // Clear checked loans on new search
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
      } finally {
        this.isLoading = false;
      }
    },

    clearInput() {
      const allInput = document.querySelectorAll(
        "#search_form input, #search_form select:not(#loan_status)"
      );
      allInput.forEach((input) => {
        input.value = ""; // Clear other input types and select elements
      });
      this.getStudentLoanSearch();
    },
  },

  mounted() {
    this.getStudentLoanSearch();
  },

  watch: {
    itemsPerPage() {
      this.getStudentLoanSearch();
    },
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

 .reflective-green {
    color: #39ff14; /* เขียวนีออน */
    text-shadow:
      0 0 5px #39ff14,
      0 0 10px #39ff14,
      0 0 20px #39ff14,
      0 0 40px #0f0;
    font-weight: bold;
  }
</style>
