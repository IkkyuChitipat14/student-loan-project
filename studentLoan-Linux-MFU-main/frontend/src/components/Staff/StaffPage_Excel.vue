<template>
  <div class="text-center py-5 px-5">
    <!-- Button trigger modal 
    <button
      type="button"
      class="btn btn-primary"
      data-bs-toggle="modal"
      data-bs-target="#staticBackdrop"
    >
      Launch static backdrop modal
    </button> -->
    <!-- Modal -->
    <div
      ref="staticBackdrop"
      class="modal modal-xl fade"
      id="staticBackdrop"
      data-bs-backdrop="static"
      data-bs-keyboard="false"
      tabindex="-1"
      aria-labelledby="staticBackdropLabel"
      aria-hidden="true"
    >
      <div class="modal-dialog modal-dialog-scrollable">
        <div class="modal-content border border-1 border-white shadow">
          <div
            v-if="isLoading"
            class="position-absolute w-100 h-100 d-flex align-items-center justify-content-center"
            style="background-color: rgba(255, 255, 255, 0.7); z-index: 1050"
          >
            <div class="spinner-border text-danger" role="status">
              <span class="visually-hidden">Loading...</span>
            </div>
          </div>
          <!-- First part: original header stays the same -->
          <div
            class="modal-header text-white shadow"
            style="background-color: #964040"
          >
            <h5 class="modal-title" id="staticBackdropLabel">
              รายการคำขอกู้ยืมเงินของนักศึกษา
            </h5>
            <button
              type="button"
              class="btn-close btn-close-white"
              data-bs-dismiss="modal"
              aria-label="Close"
            ></button>
          </div>

          <!-- Divider line -->
          <hr style="margin: 0; border-color: #964040" />

          <!-- Second part: empty or with some placeholder text -->
          <div
            class="modal-header text-white shadow rounded-0"
            style="
              background-color: #964040;
              min-height: 50px;
              display: flex;
              align-items: center;
              justify-content: center;
            "
          >
            <!-- You can replace this with any text or leave empty -->
            <div style="display: flex; flex-wrap: wrap; gap: 10px">
              <div
                v-for="key in Object.keys(keyLabels)"
                :key="key"
                style="display: inline-flex; align-items: center; gap: 5px"
              >
                <input
                  type="checkbox"
                  :id="`chk_${key}`"
                  :value="key"
                  v-model="checkBoxTable"
                  class="form-check-input"
                />
                <label class="form-check-label" :for="`chk_${key}`">{{
                  keyLabels[key]
                }}</label>
              </div>
            </div>
          </div>

          <!-- Body -->
          <div class="modal-body">
            <div class="table-responsive px-3">
              <table class="table table-striped table-hover table-bordered">
                <thead>
                  <tr>
                    <th
                      v-for="(column, index) in columns"
                      :key="column.key"
                      draggable="true"
                      @dragstart="onDragStart(index)"
                      @dragover.prevent
                      @drop="onDrop(index)"
                      style="min-width: 150px"
                    >
                      {{ column.label }}
                    </th>
                  </tr>
                </thead>
                <tbody>
                  <tr
                    v-for="(row, rowIndex) in tableData"
                    :key="rowIndex"
                    style="min-width: 150px"
                  >
                    <td v-for="col in columns" :key="col.key">
                      {{ row[col.key] }}
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
          <div
            class="modal-footer justify-content-between align-items-center"
            style="background-color: #964040"
          >
            <p class="mb-0 text-white fw-bold">
              คำข้อกู้ทั้งหมด: {{ tableData.length }}
            </p>
            <div>
              <button
                type="button"
                class="btn btn-secondary shadow border border-1 me-2"
                data-bs-dismiss="modal"
              >
                ปิด
              </button>
              <button
                type="button"
                class="btn btn-danger border shadow me-2"
                @click="downloadPdf"
              >
                PDF
              </button>

              <button
                type="button"
                class="btn btn-success border shadow"
                @click="downloadExcel"
              >
                Excel
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
// import Swal from "sweetalert2";
// import AlertBox from "../AlertBox.vue";
import { Modal } from "bootstrap";

export default {
  name: "StaffPageExcel",
  props: {
    exampleID: {
      type: Array,
      default: () => [],
    },
  },
  data() {
    return {
      isLoading: false,
      loanData: [],
      columns: [],
      tableData: [],
      loanPurposeOptions: [
        "ค่าเล่าเรียน",
        "ค่าใช้จ่ายที่เกี่ยวเนื่องกับการศึกษา",
        "ค่าครองชีพ",
      ],
      keysToShow: [
        "index",
        "created_at",
        "user_studentID",
        "user_fullname",
        "user_citizenID",
        "user_gpax",
        "user_faculty",
        "user_fieldStudy",
        // "user_studentType",
        "user_loanType",
        "total_income",
        "loan_status",
      ],
      keyLabels: {
        index: "ลำดับ",
        created_at: "วันที่ยื่น",
        user_studentID: "รหัสนักศึกษา",
        user_fullname: "ชื่อ-นามสกุล",
        user_citizenID: "เลขบัตรประชาชน",
        user_lvlStudy: "ระดับการศึกษา",
        user_yearStudy: "ปีการศึกษา",
        user_semesterStudy: "ภาคเรียน",
        user_faculty: "สำนักวิชา",
        user_fieldStudy: "สาขาวิชา",
        user_gpax: "ผลการเรียนเฉลี่ยสะสม(GPAX)",
        user_loanType: "ลักษณะของผู้กู้ยืม",
        loan_status: "สถานะแบบคำขอกู้ยืม",
        user_studentType: "ประเภทผู้กู้ยืม",
        total_income: "รายได้ครอบครัว",
      },
      checkBoxTable: [],

      draggingColumnIndex: null,
    };
  },
  methods: {
    async openModal(loanIds) {
      await this.getLoanData(loanIds);
      const modalElement = new Modal(document.getElementById("staticBackdrop"));
      modalElement.show();
    },

    async getLoanData(variable) {
      try {
        const ids = Array.isArray(variable) ? variable : [variable]; // force array

        const response = await fetch(
          `${process.env.VUE_APP_API_BASE_URL}/staff/get/loan/data/bulk`,
          {
            method: "POST",
            headers: {
              "Content-Type": "application/json",
            },
            credentials: "include",
            body: JSON.stringify({
              ids: ids,
            }),
          }
        );

        if (!response.ok) throw new Error("Failed to fetch loan data");

        const decryptedDataArray = await response.json();
        this.loanData = decryptedDataArray;

        this.generateTable();
      } catch (error) {
        console.error("Error:", error);
      }
    },

    generateTable() {
      // Sort loanData by created_at descending (latest first)
      this.loanData.sort((a, b) => {
        const dateA = new Date(a.created_at || 0).getTime();
        const dateB = new Date(b.created_at || 0).getTime();
        return dateB - dateA;
      });

      this.columns = this.keysToShow.map((key) => ({
        key,
        label: this.keyLabels[key] || key,
      }));

      this.tableData = this.loanData.map((item, index) => {
        const row = {};
        this.keysToShow.forEach((key) => {
          if (key === "total_income") {
            const incomeValues = [
              item.student_income,
              item.user_scholarship_income,
              item.dad_income,
              item.mom_income,
              item.other_income,
            ];
            const totalIncome = incomeValues.reduce((sum, val) => {
              const num = parseFloat(val);
              return sum + (isNaN(num) ? 0 : num);
            }, 0);
            row[key] = totalIncome.toLocaleString();
          } else if (key === "created_at" && typeof item[key] === "string") {
            row[key] = new Date(item[key]).toISOString().split("T")[0];
          } else if (key === "user_fullname") {
            row[key] = `${item.user_username || ""} ${
              item.user_surname || ""
            }`.trim();
          } else if (key === "index") {
            // Set index explicitly here using the map index
            row[key] = this.loanData.length - index;
          } else {
            // Default fallback for other keys
            row[key] = item[key] !== undefined ? item[key] : "-";
          }
        });
        return row;
      });
    },

    async downloadExcel() {
      this.isLoading = true;
      try {
        const labeledData = this.tableData.map((row) => {
          const labeledRow = {};
          this.checkBoxTable.forEach((key) => {
            const label = this.keyLabels[key] || key;
            labeledRow[label] = row[key];
          });
          return labeledRow;
        });

        await this.postDownloadExcel(labeledData);
      } catch (err) {
        console.error("Error downloading Excel:", err);
      } finally {
        this.isLoading = false;
      }
    },

    async postDownloadExcel(labeledData) {
      try {
        const res = await fetch(
          `${process.env.VUE_APP_API_BASE_URL}/staff/download-excel`,
          {
            method: "POST",
            credentials: "include",
            headers: {
              "Content-Type": "application/json",
            },
            body: JSON.stringify({ data: labeledData }),
          }
        );

        if (!res.ok) throw new Error(`Error ${res.status}`);

        const blob = await res.blob();

        // Trigger browser download
        const url = window.URL.createObjectURL(blob);
        const a = document.createElement("a");
        a.href = url;
        a.download = "ข้อมูลคำขอกู้_exel.xlsx";
        document.body.appendChild(a);
        a.click();
        a.remove();
        window.URL.revokeObjectURL(url);
      } catch (err) {
        console.error("Error downloading Excel:", err);
      }
    },

    async downloadPdf() {
      this.isLoading = true;
      try {
        const labeledData = this.tableData.map((row) => {
          const labeledRow = {};
          this.checkBoxTable.forEach((key) => {
            const label = this.keyLabels[key] || key;
            labeledRow[label] = row[key];
          });
          return labeledRow;
        });

        const res = await fetch(
          `${process.env.VUE_APP_API_BASE_URL}/staff/download-pdf`,
          {
            method: "POST",
            credentials: "include",
            headers: {
              "Content-Type": "application/json",
            },
            body: JSON.stringify({ data: labeledData }),
          }
        );

        if (!res.ok) throw new Error(`Error ${res.status}`);

        const blob = await res.blob();
        const url = window.URL.createObjectURL(blob);
        const a = document.createElement("a");
        a.href = url;
        a.download = "ข้อมูลคำขอกู้_pdf.pdf";
        a.click();
        window.URL.revokeObjectURL(url);
      } catch (err) {
        console.error("Error downloading PDF:", err);
      } finally {
        this.isLoading = false;
      }
    },

    onDragStart(index) {
      this.draggingColumnIndex = index;
    },

    onDrop(targetIndex) {
      const fromIndex = this.draggingColumnIndex;
      const toIndex = targetIndex;

      // Reorder columns
      const [draggedCol] = this.columns.splice(fromIndex, 1);
      this.columns.splice(toIndex, 0, draggedCol);

      // Also reorder keysToShow
      const [movedKey] = this.keysToShow.splice(fromIndex, 1);
      this.keysToShow.splice(toIndex, 0, movedKey);

      // Reset state
      this.draggingColumnIndex = null;

      console.log(
        `Swapped columns: ${draggedCol.label} moved from index ${fromIndex} to ${toIndex}`
      );
      console.log(
        "New column order:",
        this.columns.map((col) => col.label)
      );

      // Regenerate table to apply changes
      this.generateTable();
    },
  },

  mounted() {
    this.checkBoxTable = [...this.keysToShow];
    this.generateTable();
  },

  watch: {
    checkBoxTable(newVal) {
      this.keysToShow = newVal;
      this.generateTable();
    },
  },

  created() {
    this.checkBoxTable = [...this.keysToShow];
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

th {
  cursor: move;
  user-select: none;
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
