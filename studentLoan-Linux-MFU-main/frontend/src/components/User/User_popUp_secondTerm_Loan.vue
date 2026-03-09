<template>
  <AlertBox ref="alertBox" />
  <div
    class="modal fade"
    id="rejectBox"
    tabindex="-1"
    aria-labelledby="rejectBoxLabel"
    aria-hidden="true"
    ref="rejectModal"
  >
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-body">
          <div>
            <label for="reject_reason" class="text-center mb-2"
              ><h5>
                ท่านต้องการยื่นความประสงค์ขอกู้ยืม กยศ. ในภาคเรียนที่ 2 หรือไม่?
              </h5></label
            >
            <p class="text-danger">
              ***หากกดยืนยันแล้ว จะไม่สามารถย้อนกลับได้ กรุณาติดต่อ กยศ.
              เท่านั้น***
            </p>
            <input
              type="checkbox"
              name="loan_check"
              id="loan_check"
              v-model="loan_check"
            />
            <label class="mx-2" for="loan_check"
              >ฉันยอมรับ</label
            >
          </div>
        </div>
        <div class="modal-footer">
          <button
            type="button"
            class="btn btn-danger"
            data-bs-dismiss="modal"
            :disabled="!loan_check"
            @click="rejectToStudentLoan(false)"
          >
            ไม่ต้องการ
          </button>
          <button
            type="button"
            class="btn btn-primary"
            data-bs-dismiss="modal"
            :disabled="!loan_check"
            @click="rejectToStudentLoan(true)"
          >
            ต้องการ
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { Modal } from "bootstrap";
import AlertBox from "../AlertBox.vue";

export default {
  props: {
    studentID: {
      type: Number,
      required: true,
    },
  },
  data() {
    return {
      loan_check: false,
      actionTaken: false,
    };
  },
  name: "User_popUp_secondTerm_Loan",
  components: {
    AlertBox,
  },

  methods: {
    openRejectBox() {
      // Open the modal
      const modalElement = new Modal(document.getElementById("rejectBox"));
      modalElement.show();
    },

    async rejectToStudentLoan(want_to_loan) {
      this.actionTaken = true;
      try {
        const response = await fetch(
          `${process.env.VUE_APP_API_BASE_URL}/user/reject/toLoan`,
          {
            method: "POST",
            credentials: "include",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({
              want_to_loan: want_to_loan,
            }),
          }
        );

        if (response.ok) {
          const res = await response.json();
          if (res.message === "found") {
            this.$nextTick(() => {
              this.$refs.alertBox.showAlert(
                "ท่านได้ทำการยื่นความประสงค์ไปแล้ว",
                "error"
              );
              setTimeout(() => {
                this.$router.push("/user");
              }, 1000);
            });
          }
          if (want_to_loan == false) {
            this.$nextTick(() => {
              this.$refs.alertBox.showAlert(
                "ท่านได้ทำการยกเลิกการยื่นความประสงค์แล้ว",
                "error"
              );
              setTimeout(() => {
                this.$router.push("/user");
              }, 500);
            });
          }
          this.$refs.alertBox.showAlert(res.message, "success"); // assuming the response has a message
        } else if (response.status === 500) {
          const errorMessage = await response.text();
          throw new Error(errorMessage);
        } else {
          throw new Error("Connection error");
        }
      } catch (error) {
        console.error(error.message);
        this.$refs.alertBox.showAlert(error.message, "error");
      }
    },
  },
  mounted() {
    const modalEl = this.$refs.rejectModal;
    modalEl.addEventListener("hidden.bs.modal", () => {
      // Redirect only if no button was clicked
      if (!this.actionTaken) {
        this.$router.push("/user");
      }
    });
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped></style>
