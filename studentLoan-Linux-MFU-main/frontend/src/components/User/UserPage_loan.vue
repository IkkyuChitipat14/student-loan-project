<template>
  <div>
    <NavBar :studentID="studentID" />
    <AlertBox ref="alertBox" />
  </div>
  <!-- UserPage content here -->
  <div class="container-fluid screen-control bg-white">
    <div class="py-5">
      <!-- Progress bar -->
      <div class="px-0">
        <div class="con-header px-3 text-center">
          <div class="progress-container">
            <div class="progress-step active">
              <div class="step-circle">1</div>
              <div class="step-label active">ข้อมูลการศึกษา</div>
            </div>
            <div class="progress-line"></div>

            <div class="progress-step pgs-step-2">
              <div class="step-circle">2</div>
              <div class="step-label sl-step-2">ข้อมูลส่วนตัว</div>
            </div>
            <div class="progress-line"></div>

            <div class="progress-step pgs-step-3">
              <div class="step-circle">3</div>
              <div class="step-label sl-step-3">
                ข้อมูลบิดา มารดา<br />หรือผู้ปกครอง
              </div>
            </div>
            <div class="progress-line"></div>

            <div class="progress-step pgs-step-4">
              <div class="step-circle">4</div>
              <div class="step-label sl-step-4">ยืนยันคำขอกู้ยืมเงิน</div>
            </div>
            <div class="progress-line"></div>

            <div class="progress-step pgs-step-5">
              <div class="step-circle">5</div>
              <div class="step-label sl-step-5">สำเร็จ</div>
            </div>
          </div>
        </div>
      </div>

      <!-- ข้อมูลการกู้ -->
      <div class="m-2">
        <div class="con-header p-3">
          <div id="LoanForm" class="carousel slide">
            <div class="carousel-inner mb-5 bg-body-secondary shadow">
              <!-- Step 1 -->
              <div class="carousel-item px-3 py-2 active" id="form_step_1">
                <div class="col">
                  <h5 class="my-2">ปีการศึกษาที่ขอยื่นกู้</h5>
                  <hr
                    style="
                      border: none;
                      height: 2px;
                      background-color: black;
                      margin: 10px 0px;
                    "
                  />
                  <div class="row">
                    <div class="mb-3 col-12 col-md">
                      <label for="user_lvlStudy"
                        >ระดับการศึกษา<span class="text-danger">*</span></label
                      >
                      <select
                        name="user_lvlStudy"
                        id="user_lvlStudy"
                        required
                        class="form-select"
                      >
                        <option selected disabled value="">กรุณาเลือก</option>
                      </select>
                    </div>
                    <div class="mb-3 col-12 col-md">
                      <label for="user_yearStudy"
                        >ปีการศึกษา<span class="text-danger">*</span></label
                      >
                      <select
                        name="user_yearStudy"
                        id="user_yearStudy"
                        class="form-select"
                        disabled
                        required
                      >
                        <option disable value="">กรุณาเลือก</option>
                        <option selected>{{ studyYear }}</option>
                      </select>
                    </div>
                    <div class="mb-3 col-12 col-md">
                      <label for="user_semesterStudy"
                        >ภาคเรียน<span class="text-danger">*</span></label
                      >
                      <select
                        name="user_semesterStudy"
                        id="user_semesterStudy"
                        class="form-select"
                        disabled
                        required
                      >
                        <option disabled value="">กรุณาเลือก</option>
                        <option selected>{{ studySemester }}</option>
                      </select>
                    </div>
                  </div>

                  <div class="row">
                    <div class="mb-3 col-md">
                      <label for="user_faculty"
                        >สำนักวิชา<span class="text-danger">*</span></label
                      >
                      <select
                        name="user_faculty"
                        id="user_faculty"
                        class="form-select"
                        @change="getStudyField($event.target.value)"
                        required
                      >
                        <option selected disabled value="">กรุณาเลือก</option>
                        <option value="สำนักวิชา">สำนักวิชา</option>
                      </select>
                    </div>
                    <div class="mb-3 col-md">
                      <label for="user_fieldStudy"
                        >สาขาวิชา<span class="text-danger">*</span></label
                      >
                      <select
                        name="user_fieldStudy"
                        id="user_fieldStudy"
                        class="form-select"
                        required
                      >
                        <option value="" selected>กรุณาเลือกสำนักวิชา</option>
                      </select>
                    </div>
                  </div>
                  <div class="mb-3">
                    <label for="user_loanType"
                      >ลักษณะของผู้กู้ยืม<span class="text-danger"
                        >*</span
                      ></label
                    >
                    <select
                      name="user_loanType"
                      id="user_loanType"
                      class="form-select w-25"
                      style="min-width: 150px"
                      required
                    >
                      <option disabled selected value="">กรุณาเลือก</option>
                      <option value="ลักษณะที่ 1">ลักษณะที่ 1</option>
                      <option value="ลักษณะที่ 2">ลักษณะที่ 2</option>
                    </select>
                  </div>
                  <div class="mb-3">
                    <label for="user_studentID"
                      >รหัสนักศึกษา<span class="text-danger">*</span></label
                    >
                    <input
                      id="user_studentID"
                      type="number"
                      class="form-control w-25"
                      style="min-width: 150px"
                      disabled
                      required
                      :value="studentID"
                    />
                  </div>
                  <div class="mb-3">
                    <label for="user_gpax"
                      >ผลการเรียนเฉลี่ยสะสม(GPAX)<span class="text-danger"
                        >*</span
                      ><br />
                      <small class="text-secondary"
                        >กรุณากรอกตัวเลขทศนิยม เช่น 3.00, 2.59</small
                      >
                    </label>

                    <input
                      id="user_gpax"
                      type="number"
                      @keydown="input_number_block_mathsymbol_gpax"
                      @input="
                        lenght_Validation($event, 4);
                        validateNoLeadingZeros($event);
                      "
                      class="form-control w-25"
                      style="min-width: 150px"
                      @wheel.prevent
                      required
                    />
                  </div>
                </div>
              </div>

              <!-- Step 2 -->
              <div class="carousel-item px-3 py-2" id="form_step_2">
                <h5 class="my-2">
                  ข้อมูลส่วนตัว<span class="text-danger">*</span>
                </h5>
                <hr
                  style="
                    border: none;
                    height: 2px;
                    background-color: black;
                    margin: 10px 0px;
                  "
                />

                <div class="mb-2">
                  <label for="user_username"
                    >ชื่อ<span class="text-danger">*</span></label
                  >
                  <input
                    id="user_username"
                    type="text"
                    class="form-control"
                    required
                  />
                </div>

                <div class="mb-2">
                  <label for="user_surname"
                    >นามสกุล<span class="text-danger">*</span></label
                  >
                  <input
                    id="user_surname"
                    type="text"
                    class="form-control"
                    required
                  />
                </div>

                <div class="mb-2">
                  <label for="user_old"
                    >อายุ<span class="text-danger">*</span></label
                  >
                  <input
                    id="user_old"
                    type="number"
                    @keydown="input_number_block_mathsymbol"
                    class="form-control"
                    required
                    @wheel.prevent
                  />
                </div>

                <div class="mb-2">
                  <label for="user_phoneNumber"
                    >เบอร์โทรศัพท์เคลื่อนที่<span class="text-danger"
                      >*</span
                    ></label
                  >
                  <input
                    id="user_phoneNumber"
                    type="number"
                    @keydown="input_number_block_mathsymbol"
                    @input="lenght_Validation($event, 10)"
                    class="form-control"
                    required
                    @wheel.prevent
                  />
                </div>

                <div class="mb-2">
                  <label for="user_citizenID"
                    >หมายเลขบัตรประชาชน<span class="text-danger">*</span></label
                  >
                  <input
                    id="user_citizenID"
                    type="number"
                    @keydown="input_number_block_mathsymbol"
                    @input="lenght_Validation($event, 13)"
                    class="form-control"
                    required
                    @wheel.prevent
                  />
                </div>

                <div class="mb-4">
                  <p class="m-0">
                    จบการศึกษาระดับ<span class="text-danger">*</span>
                  </p>
                  <select
                    name="user_graduateLvl"
                    id="user_graduateLvl"
                    class="form-select w-25"
                    style="min-width: 150px"
                    required
                  ></select>
                </div>

                <div
                  class="mb-4"
                  id="div_fee_checkbox"
                  @change="removeError($event)"
                >
                  <p class="m-0">
                    ได้รับค่าใช้จ่ายในชีวิตประจำวัน (เลือกได้มากกว่า 1 ข้อ)<span
                      class="text-danger"
                      >*</span
                    >
                  </p>
                  <div>
                    <!-- ได้รับค่าใช้จ่ายในชีวิตประจำวัน -->
                    <div id="user_DailyExpenses"></div>

                    <!-- This is too custom to be import from backend -->
                    <div>
                      <input
                        type="checkbox"
                        name="dailyFee"
                        value="จากการประกอบอาชีพ"
                        id="จากการประกอบอาชีพ"
                        v-model="finance_income_checkbox"
                        required
                      />
                      <label for="จากการประกอบอาชีพ">จากการประกอบอาชีพ</label>
                    </div>
                    <div v-if="finance_income_checkbox">
                      <div>
                        <div class="d-flex align-items-center mb-2">
                          <label for="user_job">อาชีพ</label>
                          <input
                            type="text"
                            id="user_job"
                            class="form-control ms-2"
                            :required="finance_income_checkbox"
                            style="width: 150px"
                            v-model="user_job"
                          />
                          <span class="text-danger">*</span>
                        </div>
                        <div class="d-flex align-items-center">
                          <label for="user_job_income" class="me-2"
                            >รายได้</label
                          >
                          <input
                            type="number"
                            id="user_job_income"
                            class="form-control me-2"
                            :required="finance_income_checkbox"
                            @keydown="input_number_block_mathsymbol"
                            @wheel.prevent
                            style="width: 150px"
                            v-model="user_job_income"
                          />
                          <label for="user_job_income" class="mb-0">
                            บาท/ปี<span class="text-danger">*</span>
                          </label>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>

                <div
                  class="mb-4"
                  id="div_feeused_checkbox"
                  @change="removeError($event)"
                >
                  <p class="m-0">
                    มีความประสงค์จะขอกู้ยืมเพื่อใช้ในการศึกษา (เลือกได้มากกว่า 1
                    ข้อ)<span class="text-danger">*</span>
                  </p>

                  <div id="user_feeused"></div>
                </div>

                <div class="mb-3">
                  <label for="Public_Service_Number">ชั่วโมงจิตสาธารณะ </label>
                  <div class="d-flex">
                    <label for="Public_Service_Number" class="my-auto">
                      จำนวน</label
                    >
                    <input
                      type="number"
                      @wheel.prevent
                      @keydown="input_number_block_mathsymbol"
                      id="Public_Service_Number"
                      class="form-control w-25 mx-2"
                      style="min-width: 75px"
                      required
                    />
                    <label for="Public_Service_Number" class="my-auto"
                      >ชั่วโมง<span class="text-danger">*</span></label
                    >
                  </div>
                </div>
                <div class="mb-3">
                  <label for="Public_Service_File"
                    >Pdf กิจกรรมจิตสาธารณะ<span class="text-danger">*</span>
                    <br />
                    <small class="text-secondary"
                      >ไฟล์ PDF ขนาดไม่เกิน 10MB</small
                    >
                  </label>
                  <input
                    class="d-block w-50"
                    type="file"
                    @change="input_file_size_limit($event)"
                    name="Public_Service_File"
                    id="Public_Service_File"
                    accept=".pdf"
                    required
                    v-if="!publicFile_useOld"
                  />
                  <div class="my-2" v-if="publicFile">
                    <div class="d-flex align-items-center gap-2">
                      <span>ไฟล์เก่า:</span>
                      <a
                        :href="getFileUrl(publicFile)"
                        target="_blank"
                        rel="noopener noreferrer"
                        class="text-primary text-decoration-underline"
                      >
                        คลิ๊กเพื่อดูไฟล์
                      </a>
                      <button
                        class="btn btn-outline-info btn-sm"
                        @click="publicFile_useOld = true"
                        :disabled="publicFile_useOld"
                      >
                        ใช้ไฟล์เก่า
                      </button>
                      <i
                        class="fa-solid fa-check text-success"
                        v-if="publicFile_useOld"
                      ></i>
                    </div>
                  </div>
                </div>
              </div>

              <!-- Step 3 -->
              <div class="carousel-item p-3 text-black" id="form_step_3">
                <!-- DAD -->
                <div class="bg-white mb-2 border border-2 rounded-1">
                  <h5 class="my-2 p-2">บิดา</h5>
                  <hr
                    style="border: none; height: 2px; background-color: black"
                  />
                  <div>
                    <div class="p-2">
                      <p>สถานะ<span class="text-danger">*</span></p>

                      <select
                        name="dad_status"
                        id="dad_status"
                        class="form-select w-25 mb-4"
                        required
                        @change="checkDadStatus"
                      >
                        <option selected disabled value="">กรุณาเลือก</option>
                        <option value="มีชีวิตอยู่">มีชีวิตอยู่</option>
                        <option value="เสียชีวิต">เสียชีวิต</option>
                        <option value="ไม่ทราบข้อมูล">ไม่ทราบข้อมูล</option>
                      </select>

                      <div class="p-2" v-if="dad_death">
                        <div class="d-grid">
                          <label for="dad_death_certificate_file"
                            >แนบใบมรณะบัตร
                            <br />
                            <small class="text-secondary"
                              >ไฟล์ PDF ขนาดไม่เกิน 10MB<span
                                class="text-danger"
                                >*</span
                              ></small
                            ></label
                          >
                          <input
                            type="file"
                            @change="input_file_size_limit($event)"
                            id="dad_death_certificate_file"
                            accept=".pdf"
                            :required="dad_death"
                            v-if="!dad_death_certificate_file_useOld"
                          />
                          <div class="my-2" v-if="dad_death_certificate_file">
                            <div class="d-flex align-items-center gap-2">
                              <span>ไฟล์เก่า:</span>
                              <a
                                :href="getFileUrl(dad_death_certificate_file)"
                                target="_blank"
                                rel="noopener noreferrer"
                                class="text-primary text-decoration-underline"
                              >
                                คลิ๊กเพื่อดูไฟล์
                              </a>
                              <button
                                class="btn btn-outline-info btn-sm"
                                @click="
                                  dad_death_certificate_file_useOld = true
                                "
                                :disabled="dad_death_certificate_file_useOld"
                              >
                                ใช้ไฟล์เก่า
                              </button>
                              <i
                                class="fa-solid fa-check text-success"
                                v-if="dad_death_certificate_file_useOld"
                              ></i>
                            </div>
                          </div>
                        </div>
                      </div>

                      <!-- แนบหนังสือรับรองสถานะภาพครอบครัว -->
                      <div class="p-2" v-if="dad_unknown">
                        <div class="d-grid">
                          <label for="dad_family_status_certificate_file"
                            >แนบหนังสือรับรองสถานะภาพครอบครัว
                            <br />
                            <small class="text-secondary"
                              >ไฟล์ PDF ขนาดไม่เกิน 10MB<span
                                class="text-danger"
                                >*</span
                              ></small
                            ></label
                          >
                          <input
                            type="file"
                            @change="input_file_size_limit($event)"
                            id="dad_family_status_certificate_file"
                            accept=".pdf"
                            :required="dad_unknown"
                            v-if="!dad_family_status_certificate_file_useOld"
                          />
                          <div
                            class="my-2"
                            v-if="dad_family_status_certificate_file"
                          >
                            <div class="d-flex align-items-center gap-2">
                              <span>ไฟล์เก่า:</span>
                              <a
                                :href="
                                  getFileUrl(dad_family_status_certificate_file)
                                "
                                target="_blank"
                                rel="noopener noreferrer"
                                class="text-primary text-decoration-underline"
                              >
                                คลิ๊กเพื่อดูไฟล์
                              </a>
                              <button
                                class="btn btn-outline-info btn-sm"
                                @click="
                                  dad_family_status_certificate_file_useOld = true
                                "
                                :disabled="
                                  dad_family_status_certificate_file_useOld
                                "
                              >
                                ใช้ไฟล์เก่า
                              </button>
                              <i
                                class="fa-solid fa-check text-success"
                                v-if="dad_family_status_certificate_file_useOld"
                              ></i>
                            </div>
                          </div>
                        </div>
                      </div>

                      <div id="dad_info_from" v-if="showInput_dad">
                        <div class="mb-3">
                          <label for="dad_citizenID"
                            >เลขบัตรประชาชน<span class="text-danger"
                              >*</span
                            ></label
                          >
                          <input
                            id="dad_citizenID"
                            type="number"
                            @wheel.prevent
                            @keydown="input_number_block_mathsymbol"
                            @input="lenght_Validation($event, 13)"
                            class="form-control mt-2 w-50"
                            :required="showInput_dad"
                          />
                        </div>

                        <div class="row">
                          <div class="mb-3 col">
                            <label for="dad_name"
                              >ชื่อ<span class="text-danger">*</span></label
                            >
                            <input
                              id="dad_name"
                              type="text"
                              class="form-control mt-2"
                              :required="showInput_dad"
                            />
                          </div>

                          <div class="mb-3 col-12 col-md">
                            <label for="dad_surname"
                              >นามสกุล<span class="text-danger">*</span></label
                            >
                            <input
                              id="dad_surname"
                              type="text"
                              class="form-control mt-2"
                              :required="showInput_dad"
                            />
                          </div>
                        </div>

                        <div class="row">
                          <div class="mb-3 col">
                            <label for="dad_phoneNumber"
                              >เบอร์โทรศัพท์เคลื่อนที่<span class="text-danger"
                                >*</span
                              ></label
                            >
                            <input
                              id="dad_phoneNumber"
                              type="number"
                              @wheel.prevent
                              @keydown="input_number_block_mathsymbol"
                              @input="lenght_Validation($event, 10)"
                              class="form-control mt-2"
                              :required="showInput_dad"
                            />
                          </div>

                          <div class="mb-3 col-12 col-md">
                            <label for="dad_email">อีเมล</label>
                            <input
                              id="dad_email"
                              type="email"
                              class="form-control mt-2"
                            />
                          </div>
                        </div>

                        <div class="row">
                          <div class="mb-3 col">
                            <label for="dad_job"
                              >ปัจจุบันประกอบอาชีพ<span class="text-danger"
                                >*</span
                              ></label
                            >
                            <input
                              id="dad_job"
                              type="text"
                              class="form-control mt-2"
                              :required="showInput_dad"
                            />
                          </div>

                          <div class="mb-3 col-12 col-md">
                            <label for="dad_income"
                              >มีรายได้บาท/ปี (ไม่หักค่าใช้จ่าย)<span
                                class="text-danger"
                                >*</span
                              ></label
                            >
                            <input
                              id="dad_income"
                              type="number"
                              @wheel.prevent
                              @keydown="input_number_block_mathsymbol"
                              class="form-control mt-2"
                              :required="showInput_dad"
                            />
                          </div>

                          <div class="mb-3">
                            <label for="dad_file"
                              >เอกสาร รับรองรายได้ บิดา
                              <br />
                              <small class="text-secondary"
                                >ไฟล์ PDF ขนาดไม่เกิน 10MB<span
                                  class="text-danger"
                                  >*</span
                                ></small
                              >
                            </label>
                            <input
                              id="dad_file"
                              type="file"
                              @change="input_file_size_limit($event)"
                              class="form-control mt-2 w-50"
                              accept=".pdf"
                              required
                              v-if="!dadFile_useOld"
                            />
                            <div class="my-2" v-if="dadFile">
                              <div class="d-flex align-items-center gap-2">
                                <span>ไฟล์เก่า:</span>
                                <a
                                  :href="getFileUrl(dadFile)"
                                  target="_blank"
                                  rel="noopener noreferrer"
                                  class="text-primary text-decoration-underline"
                                >
                                  คลิ๊กเพื่อดูไฟล์
                                </a>
                                <button
                                  class="btn btn-outline-info btn-sm"
                                  @click="dadFile_useOld = true"
                                  :disabled="dadFile_useOld"
                                >
                                  ใช้ไฟล์เก่า
                                </button>
                                <i
                                  class="fa-solid fa-check text-success"
                                  v-if="dadFile_useOld"
                                ></i>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>

                <!-- MOM -->
                <div class="bg-white mb-2 border border-2 rounded-1">
                  <h5 class="my-2 p-2">มารดา</h5>
                  <hr
                    style="border: none; height: 2px; background-color: black"
                  />
                  <div class="p-2">
                    <div>
                      <p>สถานะ<span class="text-danger">*</span></p>
                      <select
                        name="mom_status"
                        id="mom_status"
                        class="form-select w-25 mb-4"
                        required
                        @change="checkMomStatus"
                      >
                        <option selected disabled value="">กรุณาเลือก</option>
                        <option value="มีชีวิตอยู่">มีชีวิตอยู่</option>
                        <option value="เสียชีวิต">เสียชีวิต</option>
                        <option value="ไม่ทราบข้อมูล">ไม่ทราบข้อมูล</option>
                      </select>
                    </div>

                    <div class="p-2" v-if="mom_death">
                      <div class="d-grid">
                        <label for="mom_death_certificate_file"
                          >แนบใบมรณะบัตร
                          <br />
                          <small class="text-secondary"
                            >ไฟล์ PDF ขนาดไม่เกิน 10MB<span class="text-danger"
                              >*</span
                            ></small
                          ></label
                        >
                        <input
                          type="file"
                          @change="input_file_size_limit($event)"
                          id="mom_death_certificate_file"
                          accept=".pdf"
                          :required="mom_death"
                          v-if="!mom_death_certificate_file_useOld"
                        />
                      </div>
                      <div class="my-2" v-if="mom_death_certificate_file">
                        <div class="d-flex align-items-center gap-2">
                          <span>ไฟล์เก่า:</span>
                          <a
                            :href="getFileUrl(mom_death_certificate_file)"
                            target="_blank"
                            rel="noopener noreferrer"
                            class="text-primary text-decoration-underline"
                          >
                            คลิ๊กเพื่อดูไฟล์
                          </a>
                          <button
                            class="btn btn-outline-info btn-sm"
                            @click="mom_death_certificate_file_useOld = true"
                            :disabled="mom_death_certificate_file_useOld"
                          >
                            ใช้ไฟล์เก่า
                          </button>
                          <i
                            class="fa-solid fa-check text-success"
                            v-if="mom_death_certificate_file_useOld"
                          ></i>
                        </div>
                      </div>
                    </div>

                    <!-- แนบหนังสือรับรองสถานะภาพครอบครัว -->
                    <div class="p-2" v-if="mom_unknown">
                      <div class="d-grid">
                        <label for="mom_family_status_certificate_file"
                          >แนบหนังสือรับรองสถานะภาพครอบครัว
                          <br />
                          <small class="text-secondary"
                            >ไฟล์ PDF ขนาดไม่เกิน 10MB<span class="text-danger"
                              >*</span
                            ></small
                          ></label
                        >
                        <input
                          type="file"
                          @change="input_file_size_limit($event)"
                          id="mom_family_status_certificate_file"
                          accept=".pdf"
                          :required="mom_unknown"
                          v-if="!mom_family_status_certificate_file_useOld"
                        />
                        <div
                          class="my-2"
                          v-if="mom_family_status_certificate_file"
                        >
                          <div class="d-flex align-items-center gap-2">
                            <span>ไฟล์เก่า:</span>
                            <a
                              :href="
                                getFileUrl(mom_family_status_certificate_file)
                              "
                              target="_blank"
                              rel="noopener noreferrer"
                              class="text-primary text-decoration-underline"
                            >
                              คลิ๊กเพื่อดูไฟล์
                            </a>
                            <button
                              class="btn btn-outline-info btn-sm"
                              @click="
                                mom_family_status_certificate_file_useOld = true
                              "
                              :disabled="
                                mom_family_status_certificate_file_useOld
                              "
                            >
                              ใช้ไฟล์เก่า
                            </button>
                            <i
                              class="fa-solid fa-check text-success"
                              v-if="mom_family_status_certificate_file_useOld"
                            ></i>
                          </div>
                        </div>
                      </div>
                    </div>

                    <div id="mom_info_from" v-if="showInput_mom">
                      <div class="mb-3">
                        <label for="mom_citizenID"
                          >เลขบัตรประชาชน<span class="text-danger"
                            >*</span
                          ></label
                        >
                        <input
                          id="mom_citizenID"
                          type="number"
                          @wheel.prevent
                          @keydown="input_number_block_mathsymbol"
                          @input="lenght_Validation($event, 13)"
                          class="form-control mt-2 w-50"
                          :required="showInput_mom"
                        />
                      </div>

                      <div class="row">
                        <div class="mb-3 col">
                          <label for="mom_name"
                            >ชื่อ<span class="text-danger">*</span></label
                          >
                          <input
                            id="mom_name"
                            type="text"
                            class="form-control mt-2"
                            :required="showInput_mom"
                          />
                        </div>

                        <div class="mb-3 col-12 col-md">
                          <label for="mom_surname"
                            >นามสกุล<span class="text-danger">*</span></label
                          >
                          <input
                            id="mom_surname"
                            type="text"
                            class="form-control mt-2"
                            :required="showInput_mom"
                          />
                        </div>
                      </div>

                      <div class="row">
                        <div class="mb-3 col">
                          <label for="mom_phoneNumber"
                            >เบอร์โทรศัพท์เคลื่อนที่<span class="text-danger"
                              >*</span
                            ></label
                          >
                          <input
                            id="mom_phoneNumber"
                            type="number"
                            @wheel.prevent
                            @keydown="input_number_block_mathsymbol"
                            @input="lenght_Validation($event, 10)"
                            class="form-control mt-2"
                            :required="showInput_mom"
                          />
                        </div>

                        <div class="mb-3 col-12 col-md">
                          <label for="mom_email">อีเมล</label>
                          <input
                            id="mom_email"
                            type="email"
                            class="form-control mt-2"
                          />
                        </div>
                      </div>

                      <div class="row">
                        <div class="mb-3 col">
                          <label for="mom_job"
                            >ปัจจุบันประกอบอาชีพ<span class="text-danger"
                              >*</span
                            ></label
                          >
                          <input
                            id="mom_job"
                            type="text"
                            class="form-control mt-2"
                            :required="showInput_mom"
                          />
                        </div>

                        <div class="mb-3 col-12 col-md">
                          <label for="mom_income"
                            >มีรายได้บาท/ปี (ไม่หักค่าใช้จ่าย)<span
                              class="text-danger"
                              >*</span
                            ></label
                          >
                          <input
                            id="mom_income"
                            type="number"
                            @wheel.prevent
                            @keydown="input_number_block_mathsymbol"
                            class="form-control mt-2"
                            :required="showInput_mom"
                          />
                        </div>

                        <div class="mb-3">
                          <label for="mom_file"
                            >เอกสาร รับรองรายได้ มารดา
                            <br />
                            <small class="text-secondary"
                              >ไฟล์ PDF ขนาดไม่เกิน 10MB<span
                                class="text-danger"
                                >*</span
                              ></small
                            >
                          </label>
                          <input
                            id="mom_file"
                            type="file"
                            @change="input_file_size_limit($event)"
                            class="form-control mt-2 w-50"
                            accept=".pdf"
                            required
                            v-if="!momFile_useOld"
                          />
                          <div class="my-2" v-if="momFile">
                            <div class="d-flex align-items-center gap-2">
                              <span>ไฟล์เก่า:</span>
                              <a
                                :href="getFileUrl(momFile)"
                                target="_blank"
                                rel="noopener noreferrer"
                                class="text-primary text-decoration-underline"
                              >
                                คลิ๊กเพื่อดูไฟล์
                              </a>
                              <button
                                class="btn btn-outline-info btn-sm"
                                @click="momFile_useOld = true"
                                :disabled="momFile_useOld"
                              >
                                ใช้ไฟล์เก่า
                              </button>
                              <i
                                class="fa-solid fa-check text-success"
                                v-if="momFile_useOld"
                              ></i>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>

                <div class="bg-white mb-2 border border-2 rounded-1">
                  <h5 class="my-2 p-2">สถานภาพสมรสของบิดา-มารดา</h5>
                  <hr
                    style="border: none; height: 2px; background-color: black"
                  />
                  <select
                    name="Marital_status_of_parents"
                    id="Marital_status_of_parents"
                    class="form-select w-25 mb-4 ms-2"
                    v-model="Marital_status_of_parents"
                  >
                    <option selected disabled value="">กรุณาเลือก</option>
                    <option
                      value="สมรส"
                      v-if="
                        showInput_mom || showInput_dad || dad_death || mom_death
                      "
                    >
                      สมรส
                    </option>
                    <option
                      value="หย่าร้าง"
                      v-if="
                        showInput_mom || showInput_dad || dad_death || mom_death
                      "
                    >
                      หย่าร้าง
                    </option>
                    <option
                      value="แยกทางกันโดยมิได้จดทะเบียนสมรส"
                      v-if="
                        showInput_mom || showInput_dad || dad_death || mom_death
                      "
                    >
                      แยกทางกันโดยมิได้จดทะเบียนสมรส
                    </option>
                    <option
                      value="แยกทางกันโดยมิได้จดทะเบียนหย่า"
                      v-if="
                        showInput_mom || showInput_dad || dad_death || mom_death
                      "
                    >
                      แยกทางกันโดยมิได้จดทะเบียนหย่า
                    </option>
                    <option
                      value="ไม่ทราบ"
                      v-if="
                        !(
                          showInput_mom ||
                          showInput_dad ||
                          dad_death ||
                          mom_death
                        )
                      "
                    >
                      ไม่ทราบ
                    </option>
                  </select>
                  <div class="p-2" v-if="show_marriage_pdf">
                    <div class="d-grid">
                      <label for="Marital_status_of_parents_pdf"
                        >แนบเอกสารประกอบ
                        <br />
                        <small class="text-secondary"
                          >ไฟล์ PDF ขนาดไม่เกิน 10MB<span class="text-danger"
                            >*</span
                          ></small
                        ></label
                      >
                      <input
                        type="file"
                        @change="input_file_size_limit($event)"
                        id="Marital_status_of_parents_file"
                        accept=".pdf"
                        :required="show_marriage_pdf"
                        v-if="!maritalFile_useOld"
                      />
                      <div class="my-2" v-if="maritalFile">
                        <div class="d-flex align-items-center gap-2">
                          <span>ไฟล์เก่า:</span>
                          <a
                            :href="getFileUrl(maritalFile)"
                            target="_blank"
                            rel="noopener noreferrer"
                            class="text-primary text-decoration-underline"
                          >
                            คลิ๊กเพื่อดูไฟล์
                          </a>
                          <button
                            class="btn btn-outline-info btn-sm"
                            @click="maritalFile_useOld = true"
                            :disabled="maritalFile_useOld"
                          >
                            ใช้ไฟล์เก่า
                          </button>
                          <i
                            class="fa-solid fa-check text-success"
                            v-if="maritalFile_useOld"
                          ></i>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>

                <!-- Rightful guardian -->
                <div class="bg-white mb-2 border border-2 rounded-1">
                  <h5 class="my-2 p-2">
                    ผู้กู้ยืมอยู่ในความดูแลของ<span class="text-danger">*</span>
                  </h5>
                  <hr
                    style="border: none; height: 2px; background-color: black"
                  />
                  <select
                    name="rightful_guardian"
                    id="rightful_guardian"
                    class="form-select w-25 mb-4 ms-2"
                    required
                    v-model="selectedGuardian"
                  >
                    <option selected disabled value="">กรุณาเลือก</option>
                    <option
                      value="บิดา มารดา"
                      v-if="showInput_dad && showInput_mom"
                    >
                      บิดา มารดา
                    </option>
                    <option value="บิดาเพียงผู้เดียว" v-if="showInput_dad">
                      บิดาเพียงผู้เดียว
                    </option>
                    <option value="มารดาเพียงผู้เดียว" v-if="showInput_mom">
                      มารดาเพียงผู้เดียว
                    </option>
                    <option value="ผู้ปกครองไม่ใช่บิดา มารดา">
                      ผู้ปกครองไม่ใช่บิดา มารดา
                    </option>
                  </select>
                  <div class="px-2">
                    <!-- Other -->
                    <div id="guardian_other_container">
                      <div id="other_info_from" v-if="showInput_other">
                        <div class="mb-3">
                          <label for="other_citizenID"
                            >เลขบัตรประชาชน<span class="text-danger"
                              >*</span
                            ></label
                          >
                          <input
                            id="other_citizenID"
                            type="number"
                            @wheel.prevent
                            @keydown="input_number_block_mathsymbol"
                            @input="lenght_Validation($event, 13)"
                            class="form-control mt-2 w-50"
                            :required="showInput_other"
                          />
                        </div>

                        <div class="row">
                          <div class="mb-3 col">
                            <label for="other_name"
                              >ชื่อ<span class="text-danger">*</span></label
                            >
                            <input
                              id="other_name"
                              type="text"
                              class="form-control mt-2"
                              :required="showInput_other"
                            />
                          </div>

                          <div class="mb-3 col-12 col-md">
                            <label for="other_surname"
                              >นามสกุล<span class="text-danger">*</span></label
                            >
                            <input
                              id="other_surname"
                              type="text"
                              class="form-control mt-2"
                              :required="showInput_other"
                            />
                          </div>
                        </div>

                        <div class="row">
                          <div class="mb-3 col">
                            <label for="other_phoneNumber"
                              >เบอร์โทรศัพท์เคลื่อนที่<span class="text-danger"
                                >*</span
                              ></label
                            >
                            <input
                              id="other_phoneNumber"
                              type="number"
                              @wheel.prevent
                              @keydown="input_number_block_mathsymbol"
                              @input="lenght_Validation($event, 10)"
                              class="form-control mt-2"
                              :required="showInput_other"
                            />
                          </div>

                          <div class="mb-3 col-12 col-md">
                            <label for="other_email">อีเมล</label>
                            <input
                              id="other_email"
                              type="email"
                              class="form-control mt-2"
                            />
                          </div>
                        </div>

                        <div class="row">
                          <div class="mb-3 col">
                            <label for="other_job"
                              >ปัจจุบันประกอบอาชีพ<span class="text-danger"
                                >*</span
                              ></label
                            >
                            <input
                              id="other_job"
                              type="text"
                              class="form-control mt-2"
                              :required="showInput_other"
                            />
                          </div>

                          <div class="mb-3 col-12 col-md">
                            <label for="other_income"
                              >มีรายได้บาท/ปี (ไม่หักค่าใช้จ่าย)<span
                                class="text-danger"
                                >*</span
                              ></label
                            >
                            <input
                              id="other_income"
                              type="number"
                              @wheel.prevent
                              @keydown="input_number_block_mathsymbol"
                              class="form-control mt-2"
                              :required="showInput_other"
                            />
                          </div>
                        </div>

                        <div class="mb-3">
                          <label for="other_relationship"
                            >ความสัมพันธ์<span class="text-danger"
                              >*</span
                            ></label
                          >
                          <input
                            id="other_relationship"
                            type="text"
                            class="form-control mt-2 w-50"
                            :required="showInput_other"
                          />
                        </div>

                        <div class="mb-3">
                          <label for="other_file"
                            >เอกสารรับรองรายได้ผู้ปกครองที่ไม่ใช่บิดา-มารดา
                            <br />
                            <small class="text-secondary"
                              >ไฟล์ PDF ขนาดไม่เกิน 10MB<span
                                class="text-danger"
                                >*</span
                              ></small
                            ></label
                          >
                          <input
                            id="other_file"
                            type="file"
                            @change="input_file_size_limit($event)"
                            class="form-control mt-2 w-50"
                            accept=".pdf"
                            v-if="!otherFile_useOld"
                          />
                          <div class="my-2" v-if="otherFile">
                            <div class="d-flex align-items-center gap-2">
                              <span>ไฟล์เก่า:</span>
                              <a
                                :href="getFileUrl(otherFile)"
                                target="_blank"
                                rel="noopener noreferrer"
                                class="text-primary text-decoration-underline"
                              >
                                คลิ๊กเพื่อดูไฟล์
                              </a>
                              <button
                                class="btn btn-outline-info btn-sm"
                                @click="otherFile_useOld = true"
                                :disabled="otherFile_useOld"
                              >
                                ใช้ไฟล์เก่า
                              </button>
                              <i
                                class="fa-solid fa-check text-success"
                                v-if="otherFile_useOld"
                              ></i>
                            </div>
                          </div>
                        </div>

                        <div class="mb-3">
                          <label for="other_file"
                            >หนังสือรับรองการเป็นผู้อุปการะที่ไม่ใช่บิดา-มารดา
                            <br />
                            <small class="text-secondary"
                              >ไฟล์ PDF ขนาดไม่เกิน 10MB<span
                                class="text-danger"
                                >*</span
                              ></small
                            ></label
                          >
                          <input
                            id="other_NonParent_Custody_Certificate_file"
                            type="file"
                            @change="input_file_size_limit($event)"
                            class="form-control mt-2 w-50"
                            accept=".pdf"
                            v-if="!otherFile_certificate_useOld"
                          />
                          <div class="my-2" v-if="otherFile_certificate">
                            <div class="d-flex align-items-center gap-2">
                              <span>ไฟล์เก่า:</span>
                              <a
                                :href="getFileUrl(otherFile_certificate)"
                                target="_blank"
                                rel="noopener noreferrer"
                                class="text-primary text-decoration-underline"
                              >
                                คลิ๊กเพื่อดูไฟล์
                              </a>
                              <button
                                class="btn btn-outline-info btn-sm"
                                @click="otherFile_certificate_useOld = true"
                                :disabled="otherFile_certificate_useOld"
                              >
                                ใช้ไฟล์เก่า
                              </button>
                              <i
                                class="fa-solid fa-check text-success"
                                v-if="otherFile_certificate_useOld"
                              ></i>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>

              <!-- Step 4 -->
              <div class="carousel-item p-3 text-black">
                <div class="bg-white">
                  <div class="p-2">
                    <h5 class="my-auto p-2">ข้อมูลคำขอ</h5>
                  </div>
                  <hr
                    style="border: none; height: 2px; background-color: black"
                    class="p-0 m-0"
                  />

                  <!-- User Info -->
                  <div class="p-3">
                    <p class="text-secondary">ข้อมูลผู้กู้ยืมเงิน</p>
                    <div class="p-3 bg-secondary-subtle">
                      <div class="row">
                        <div class="col">
                          <div class="row">
                            <p class="col"><b>ชื่อ-นามสกุล</b></p>
                            <p class="col" id="step4_user_fullname">-</p>
                          </div>
                        </div>

                        <div class="col-12 col-md">
                          <div class="row">
                            <p class="col"><b>อายุ</b></p>
                            <p class="col" id="step4_user_old">-</p>
                          </div>
                        </div>
                      </div>

                      <div class="row"></div>

                      <div class="row">
                        <div class="col">
                          <div class="row">
                            <p class="col"><b>เบอร์โทรศัพท์เคลื่อนที่</b></p>
                            <p class="col" id="step4_user_phoneNumber">-</p>
                          </div>
                        </div>

                        <div class="col-12 col-md">
                          <div class="row">
                            <p class="col"><b>บัตรประชาชน</b></p>
                            <p class="col" id="step4_user_citizenID">-</p>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>

                  <!-- User's education info -->
                  <div class="p-3">
                    <p class="text-secondary">ข้อมูลการศึกษาที่ขอยื่นกู้</p>
                    <div class="bg-secondary-subtle">
                      <div class="p-3">
                        <div class="row">
                          <div class="col">
                            <div class="row">
                              <p class="col"><b>ระดับการศึกษา</b></p>
                              <p class="col" id="step4_user_lvlStudy">-</p>
                            </div>
                          </div>
                          <div class="col-12 col-md"></div>
                        </div>

                        <div class="row">
                          <div class="col">
                            <div class="row">
                              <p class="col"><b>ปีการศึกษา</b></p>
                              <p class="col" id="step4_user_yearStudy">-</p>
                            </div>
                          </div>

                          <div class="col-12 col-md">
                            <div class="row">
                              <p class="col"><b>ภาคเรียน</b></p>
                              <p class="col" id="step4_user_semesterStudy">-</p>
                            </div>
                          </div>
                        </div>
                      </div>

                      <hr
                        style="
                          border: none;
                          height: 2px;
                          background-color: black;
                        "
                        class="p-0 m-0"
                      />

                      <div class="p-3">
                        <div class="row">
                          <div class="col">
                            <div class="row">
                              <p class="col"><b>สำนักวิชา</b></p>
                              <p class="col" id="step4_user_faculty">-</p>
                            </div>
                          </div>
                          <div class="col-12 col-md"></div>
                        </div>

                        <div class="row">
                          <div class="col">
                            <div class="row">
                              <p class="col"><b>สาขาวิชา</b></p>
                              <p class="col" id="step4_user_fieldStudy">-</p>
                            </div>
                          </div>

                          <div class="col-12 col-md"></div>
                        </div>
                      </div>

                      <hr
                        style="
                          border: none;
                          height: 2px;
                          background-color: black;
                        "
                        class="p-0 m-0"
                      />

                      <div class="p-3">
                        <div class="row">
                          <div class="col">
                            <div class="row">
                              <p class="col"><b>รหัสนักศึกษา</b></p>
                              <p class="col" id="step4_user_studentID">-</p>
                            </div>
                          </div>
                          <div class="col-12 col-md">
                            <div class="row">
                              <p class="col"><b>GPAX</b></p>
                              <p class="col" id="step4_user_gpax">-</p>
                            </div>
                          </div>
                        </div>
                      </div>

                      <hr
                        style="
                          border: none;
                          height: 2px;
                          background-color: black;
                        "
                        class="p-0 m-0"
                      />

                      <div class="p-3">
                        <div class="row">
                          <div class="col">
                            <div class="row">
                              <p class="col"><b>จบการศึกษาระดับ</b></p>
                              <p class="col" id="step4_user_graduateLvl">-</p>
                            </div>
                          </div>
                          <div class="col-12 col-md"></div>
                        </div>
                      </div>

                      <hr
                        style="
                          border: none;
                          height: 2px;
                          background-color: black;
                        "
                        class="p-0 m-0"
                      />

                      <div class="p-3">
                        <div class="row">
                          <div class="col">
                            <div class="row">
                              <p class="col-6"><b>ชั่วโมงจิตสาธารณะ</b></p>
                              <p class="col" id="step4_Public_Service_Number">
                                -
                              </p>
                              <p class="col">ชั่วโมง</p>
                            </div>
                          </div>
                          <div class="col-12 col-md"></div>
                        </div>
                      </div>
                    </div>
                  </div>

                  <!-- User's fiance info -->
                  <div class="p-3">
                    <p class="text-secondary">ข้อมูลการเงิน</p>
                    <div class="p-3 bg-secondary-subtle">
                      <div class="row">
                        <div class="col">
                          <div class="row">
                            <p class="col">
                              <b>ได้รับค่าใช้จ่ายในชีวิตประจำวัน</b>
                            </p>
                            <div class="col-12 col-md">
                              <div class="d-grid float-start">
                                <div id="step4_dailyFee"></div>
                                <div>
                                  <input
                                    type="checkbox"
                                    id="step4_จากการประกอบอาชีพ"
                                    disabled
                                  />
                                  <p class="d-inline p-2">จากการประกอบอาชีพ</p>
                                  <div class="d-flex row">
                                    <p class="me-2 m-0 col-4">อาชีพ:</p>
                                    <p id="step4_user_job" class="m-0 col">-</p>
                                  </div>
                                  <div class="d-flex row">
                                    <p class="me-2 col-4">รายได้:</p>
                                    <p id="step4_user_job_income" class="col">
                                      -
                                    </p>
                                    <p class="col">บาท/ปี</p>
                                  </div>
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>

                      <div class="row">
                        <div class="col">
                          <div class="row">
                            <p class="col">
                              <b>
                                มีความประสงค์จะขอกู้ยืม<br />เพื่อใช้ในการศึกษา</b
                              >
                            </p>
                            <p class="col-12 col-md" id="step4_loanPurpose">
                              -
                            </p>
                          </div>
                        </div>
                      </div>

                      <div class="row">
                        <div class="col">
                          <div class="row">
                            <p class="col-6"><b>ลักษณะของผู้กู้ยืม</b></p>
                            <p class="col" id="step4_user_loanType">-</p>
                          </div>
                        </div>
                        <div class="col-12 col-md"></div>
                      </div>
                    </div>
                  </div>

                  <!-- User's father info -->
                  <div class="p-3">
                    <p class="text-secondary">ข้อมูลบิดา</p>
                    <div class="p-3 bg-secondary-subtle">
                      <div class="row">
                        <div class="col">
                          <div class="row">
                            <p class="col"><b>สถานะ</b></p>
                            <p class="col" id="step4_dad_status">-</p>
                          </div>
                        </div>

                        <div class="col"></div>
                      </div>

                      <div v-show="show_dad_info">
                        <div class="row">
                          <div class="col">
                            <div class="row">
                              <p class="col"><b>ชื่อ-นามสกุล </b></p>
                              <p class="col" id="step4_dad_fullname">-</p>
                            </div>
                          </div>

                          <div class="col">
                            <div class="row">
                              <p class="col"><b>เลขบัตรประชาชน</b></p>
                              <p class="col" id="step4_dad_citizenID">-</p>
                            </div>
                          </div>
                        </div>

                        <div class="row">
                          <div class="col">
                            <div class="row">
                              <p class="col">
                                <b>เบอร์โทรศัพท์เคลื่อนที่</b>
                              </p>
                              <p class="col" id="step4_dad_phoneNumber">-</p>
                            </div>
                          </div>

                          <div class="col">
                            <div class="row">
                              <p class="col"><b>อีเมล</b></p>
                              <p class="col" id="step4_dad_email">-</p>
                            </div>
                          </div>
                        </div>

                        <div class="row">
                          <div class="col">
                            <div class="row">
                              <p class="col"><b>อาชีพ</b></p>
                              <p class="col" id="step4_dad_job">-</p>
                            </div>
                          </div>

                          <div class="col">
                            <div class="row">
                              <p class="col"><b>มีรายได้บาท/ปี</b></p>
                              <p class="col" id="step4_dad_income">-</p>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>

                  <!-- User's mother info -->
                  <div class="p-3">
                    <p class="text-secondary">ข้อมูลมารดา</p>
                    <div class="p-3 bg-secondary-subtle">
                      <div class="row">
                        <div class="col">
                          <div class="row">
                            <p class="col"><b>สถานะ</b></p>
                            <p class="col" id="step4_mom_status">-</p>
                          </div>
                        </div>

                        <div class="col"></div>
                      </div>

                      <div v-show="show_mom_info">
                        <div class="row">
                          <div class="col">
                            <div class="row">
                              <p class="col"><b>ชื่อ-นามสกุล</b></p>
                              <p class="col" id="step4_mom_fullname">-</p>
                            </div>
                          </div>

                          <div class="col">
                            <div class="row">
                              <p class="col"><b>เลขบัตรประชาชน</b></p>
                              <p class="col" id="step4_mom_citizenID">-</p>
                            </div>
                          </div>
                        </div>

                        <div class="row">
                          <div class="col">
                            <div class="row">
                              <p class="col">
                                <b>เบอร์โทรศัพท์เคลื่อนที่ </b>
                              </p>
                              <p class="col" id="step4_mom_phoneNumber">-</p>
                            </div>
                          </div>

                          <div class="col">
                            <div class="row">
                              <p class="col"><b>อีเมล</b></p>
                              <p class="col" id="step4_mom_email">-</p>
                            </div>
                          </div>
                        </div>

                        <div class="row">
                          <div class="col">
                            <div class="row">
                              <p class="col"><b>อาชีพ</b></p>
                              <p class="col" id="step4_mom_job">-</p>
                            </div>
                          </div>

                          <div class="col">
                            <div class="row">
                              <p class="col"><b>มีรายได้บาท/ปี</b></p>
                              <p class="col" id="step4_mom_income">-</p>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>

                  <!-- dad mom mariage info -->
                  <div class="p-3">
                    <p class="text-secondary">สถานภาพสมรสของบิดา-มารดา</p>
                    <div class="p-3 bg-secondary-subtle">
                      <div class="row">
                        <div class="col">
                          <div class="row">
                            <p class="col"><b>สถานะ</b></p>
                            <p class="col" id="step4_mariage_status">-</p>
                          </div>
                        </div>
                        <div class="col"></div>
                      </div>
                    </div>
                  </div>

                  <!-- User's rightful guardian info -->
                  <div class="p-3">
                    <p class="text-secondary">
                      ข้อมูลผู้แทนโดยชอบธรรม/ผู้ปกครอง
                    </p>
                    <div class="p-3 bg-secondary-subtle">
                      <div class="row">
                        <div class="col">
                          <div class="row">
                            <p class="col"><b>ความสัมพันธ์</b></p>
                            <p class="col" id="step4_rightful_guardian">-</p>
                          </div>
                        </div>
                        <div class="col"></div>
                      </div>

                      <div v-show="show_other_info">
                        <div class="row">
                          <div class="col">
                            <div class="row">
                              <p class="col"><b>ชื่อ-นามสกุล</b></p>
                              <p class="col-auto" id="step4_other_fullname">
                                -
                              </p>
                            </div>
                          </div>

                          <div class="col">
                            <div class="row">
                              <p class="col"><b>เลขบัตรประชาชน</b></p>
                              <p class="col" id="step4_other_citizenID">-</p>
                            </div>
                          </div>
                        </div>

                        <div class="row">
                          <div class="col">
                            <div class="row">
                              <p class="col">
                                <b>เบอร์โทรศัพท์เคลื่อนที่</b>
                              </p>
                              <p class="col" id="step4_other_phoneNumber">-</p>
                            </div>
                          </div>

                          <div class="col">
                            <div class="row">
                              <p class="col"><b>อีเมล</b></p>
                              <p class="col" id="step4_other_email">-</p>
                            </div>
                          </div>
                        </div>

                        <div class="row">
                          <div class="col">
                            <div class="row">
                              <p class="col"><b>อาชีพ</b></p>
                              <p class="col" id="step4_other_job">-</p>
                            </div>
                          </div>

                          <div class="col">
                            <div class="row">
                              <p class="col"><b>มีรายได้บาท/ปี</b></p>
                              <p class="col" id="step4_other_income">-</p>
                            </div>
                          </div>
                        </div>

                        <div class="row">
                          <div class="col">
                            <div class="row">
                              <p class="col-3"><b>ความสัมพันธ์</b></p>
                              <p class="col" id="step4_other_relationship">-</p>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>

              <!-- Step 5 -->
              <div class="carousel-item p-3 text-black">
                <div class="bg-white text-center p-4">
                  <i
                    class="fa-solid fa-check"
                    style="color: #00ff00; font-size: 150px"
                  ></i>
                  <h4>เสร็จสิ้น</h4>
                  <p>คำขอกู้ของท่านถูกส่งไปยังเจ้าหน้าที่แล้ว</p>
                  <p>เจ้าหน้าที่จะทำการตรวจข้อมูลคำขอของท่าน</p>
                </div>
              </div>
            </div>

            <!-- Next and Back button -->
            <div class="from_button_control row mt-3 px-3">
              <div class="col">
                <button
                  v-if="step > 1 || step < 4"
                  class="btn btn-outline-info d-flex align-items-center float-start px-3 py-2"
                  type="button"
                  data-bs-target="#LoanForm"
                  data-bs-slide="prev"
                  @click="
                    disabledButton();
                    deleteStep();
                  "
                  :disabled="step === 1 || step === 5 || buttonStatus"
                >
                  <span>ย้อนกลับ</span>
                </button>
              </div>

              <div class="col">
                <!-- Next button -->
                <div v-if="step < 4">
                  <button
                    class="btn d-flex align-items-center float-end px-4 py-2"
                    type="button"
                    style="background-color: #964040"
                    @click="
                      disabledButton();
                      input_validation_check();
                    "
                    :disabled="buttonStatus || step === 4"
                  >
                    <span class="text-white">ถัดไป</span>
                  </button>
                </div>
                <!-- Submit button -->
                <div v-if="step === 4">
                  <button
                    class="btn btn-info d-flex align-items-center float-end px-4 py-2"
                    :disabled="buttonStatus || step < 4"
                    @click="
                      disabledButton();
                      confirmBoxForm();
                    "
                  >
                    <span>ส่งคำร้องขอ</span>
                  </button>
                </div>
                <div v-if="step === 5">
                  <button
                    class="btn btn-info d-flex align-items-center float-end px-4 py-2"
                    :disabled="buttonStatus || step < 5"
                    @click="this.$router.push('/user')"
                  >
                    <span>กลับสู่หน้าหลัก</span>
                  </button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import NavBar from "@/components/User/NavBar_user.vue";
import { Carousel } from "bootstrap";
import AlertBox from "../AlertBox.vue";
import Swal from "sweetalert2";
import { throttle } from "lodash";

export default {
  name: "UserPage_loan",
  components: {
    NavBar,
    AlertBox,
  },

  data() {
    return {
      // session
      studentID: "6531501999",
      // For from
      isSubmitting: false,
      formID: null, // For form edit
      step: 1, // from step 1-5
      studyYear: new Date().getFullYear() + 543,
      studySemester: 1,
      buttonStatus: false,
      finance_income_checkbox: false,
      showInput_dad: false,
      showInput_mom: false,
      showInput_other: false,
      show_mom_info: false,
      show_dad_info: false,
      show_other_info: false,
      dad_death: false,
      mom_death: false,
      dad_unknown: false,
      mom_unknown: false,
      show_marriage_pdf: false,
      selectedGuardian: "",
      Marital_status_of_parents: "",

      // For Validation
      UserForm: [],
      user_job: "",
      user_job_income: "",

      // session
      timeoutId: null, // Add timeoutId for session timeout
      timeoutInMS: null, // Timeout duration (15 minutes) 15 x 60 x 1000 = 60000
      timeoutWarningId: null,
      warningTimeInMS: null, // 5 mins
      activeTimeouts: [],

      // Queried file
      dadFile: null,
      momFile: null,
      otherFile: null,
      publicFile: null,
      maritalFile: null,
      otherFile_certificate: null,
      dad_death_certificate_file: null,
      mom_death_certificate_file: null,
      dad_family_status_certificate_file: null,
      mom_family_status_certificate_file: null,

      // handle edit file
      dadFile_useOld: false,
      momFile_useOld: false,
      otherFile_useOld: false,
      publicFile_useOld: false,
      maritalFile_useOld: false,
      otherFile_certificate_useOld: false,
      dad_death_certificate_file_useOld: false,
      mom_death_certificate_file_useOld: false,
      dad_family_status_certificate_file_useOld: false,
      mom_family_status_certificate_file_useOld: false,
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

    async APIsentForm() {
      if (this.isSubmitting) return;
      this.isSubmitting = true;

      try {
        const formData = new FormData();
        for (const key in this.UserForm) {
          const value = this.UserForm[key];
          if (value !== null && value !== undefined && value !== "") {
            if (Array.isArray(value)) {
              value.forEach((item, index) => {
                formData.append(`${key}[${index}]`, item);
              });
            } else if (typeof value === "object" && !(value instanceof File)) {
              formData.append(key, JSON.stringify(value));
            } else {
              formData.append(key, value);
            }
          }
        }

        const response = await fetch(
          `${process.env.VUE_APP_API_BASE_URL}/user/loan/submit_form`,
          {
            method: "POST",
            credentials: "include",
            body: formData,
          }
        );

        if (response.ok) {
          const res = await response.json();
          Swal.fire({
            icon: "success",
            title: "ส่งแบบฟอร์มสำเร็จ",
            text: res.message,
          });
          this.addStep();
        } else {
          const errorRes = await response.json().catch(() => ({}));
          const message = errorRes.message || "เกิดข้อผิดพลาดในการส่งแบบฟอร์ม";
          Swal.fire({
            icon: "error",
            title: "ผิดพลาด",
            text: message,
          });
          throw new Error(`${response.status}: ${message}`);
        }
      } catch (error) {
        console.error(error);
        Swal.fire({
          icon: "error",
          title: "เกิดข้อผิดพลาด",
          text: error.message || "ไม่สามารถส่งฟอร์มได้",
        });
      } finally {
        this.isSubmitting = false;
      }
    },

    async APIeditForm() {
      if (this.isSubmitting) return; // Prevent if already submitting
      this.isSubmitting = true;
      try {
        const formData = new FormData();
        formData.append("public_id", this.formID); // Include formID

        // Log the form data to check if it's populated correctly
        for (const key in this.UserForm) {
          const value = this.UserForm[key];

          // Skip empty keys
          if (
            key === "" ||
            value === null ||
            value === undefined ||
            value === ""
          ) {
            continue;
          }

          if (Array.isArray(value)) {
            value.forEach((item, index) => {
              formData.append(`${key}[${index}]`, item);
            });
          } else if (typeof value === "object" && !(value instanceof File)) {
            // For objects, stringify the value
            formData.append(key, JSON.stringify(value));
          } else {
            // For other values, directly append
            formData.append(key, value);
          }
        }

        const response = await fetch(
          `${process.env.VUE_APP_API_BASE_URL}/user/loan/edit_form`,
          {
            method: "POST",
            credentials: "include",
            body: formData,
          }
        );

        if (response.ok) {
          const res = await response.json();
          this.$refs.alertBox.showAlert(res.message, "success");
          this.addStep();
        } else {
          const errorText = await response.text();
          throw new Error(`Error: ${response.status} - ${errorText}`);
        }
      } catch (error) {
        console.error("Error occurred:", error.message);
        alert(`Submission failed: ${error.message}`);
        this.$refs.alertBox.showAlert("เกิดข้อผิดผลาด", "error");
      } finally {
        this.isSubmitting = false;
      }
    },

    // Progress Bar
    addStep() {
      const carousel = document.querySelector("#LoanForm");
      const carouselInstance =
        Carousel.getInstance(carousel) || new Carousel(carousel);
      if (this.step <= 6) {
        const targetElement = document.querySelector(
          `.pgs-step-${this.step + 1}`
        );
        const targetElement2 = document.querySelector(
          `.sl-step-${this.step + 1}`
        );
        targetElement.classList.add("active");
        targetElement2.classList.add("active");
        this.step++;
        carouselInstance.next();
      }
    },
    deleteStep() {
      if (this.step > 1) {
        const targetElement = document.querySelector(`.pgs-step-${this.step}`);
        const targetElement2 = document.querySelector(`.sl-step-${this.step}`);
        targetElement.classList.remove("active");
        targetElement2.classList.remove("active");
        this.step--;
      }
    },
    // =======================================================================

    // set next and back button delayed
    disabledButton() {
      this.buttonStatus = true;
      setTimeout(() => {
        this.buttonStatus = false;
      }, 500); // 500ms = 0.5 seconds
    },

    // dad select from input
    checkDadStatus(event) {
      this.showInput_dad = event.target.value === "มีชีวิตอยู่";
      this.dad_death = event.target.value === "เสียชีวิต";
      this.dad_unknown = event.target.value === "ไม่ทราบข้อมูล";
    },
    // mom select from input
    checkMomStatus(event) {
      this.showInput_mom = event.target.value === "มีชีวิตอยู่";
      this.mom_death = event.target.value === "เสียชีวิต";
      this.mom_unknown = event.target.value === "ไม่ทราบข้อมูล";
    },

    // Make input type number can only type number not the math symbols
    input_number_block_mathsymbol(event) {
      // Block 'e', '+', and '-' keys for type="number" inputs
      if (["e", "E", "+", "-", "."].includes(event.key)) {
        event.preventDefault();
      }
    },

    // Make input type number can only type number not the math symbols
    input_number_block_mathsymbol_gpax(event) {
      // Block 'e', '+', and '-' keys for type="number" inputs
      if (["e", "E", "+", "-"].includes(event.key)) {
        event.preventDefault();
      }
    },

    lenght_Validation(event, maxLength) {
      if (event.target.value.length > maxLength) {
        event.target.value = event.target.value.slice(0, maxLength); // Automatically trim the input
      }

      if (event.target.value.length < maxLength) {
        event.target.style.backgroundColor = "#FFFF99"; // Highlight background
      } else {
        event.target.style.backgroundColor = ""; // Reset background
      }
    },

    lenght_Validation_form(inputValue, expectedLength, alertMessage) {
      if (inputValue == "" || !inputValue) return true;
      if (inputValue.length < expectedLength && inputValue !== "") {
        this.$refs.alertBox.showAlert(alertMessage, "warning");
        return false;
      }
      return true;
    },

    input_file_size_limit(event) {
      const file = event.target.files[0]; // Get the first file
      if (file) {
        const maxSize = 10 * 1024 * 1024; // 10MB in bytes
        const maxFilenameLength = 150; // 150 characters

        if (file.size > maxSize) {
          event.target.value = ""; // Reset the file input
          return this.$refs.alertBox.showAlert(
            "ขนาดไฟล์ต้องไม่เกิน 10MB",
            "warning"
          );
        }

        const isPDF =
          file.type === "application/pdf" ||
          file.name.toLowerCase().endsWith(".pdf");
        if (!isPDF) {
          event.target.value = ""; // Reset the file input
          return this.$refs.alertBox.showAlert(
            "อนุญาตเฉพาะไฟล์ PDF เท่านั้น",
            "warning"
          );
        }

        // Check file name length
        if (file.name.length > maxFilenameLength) {
          event.target.value = ""; // Reset the file input
          return this.$refs.alertBox.showAlert(
            "ชื่อไฟล์ของคุณยาวเกินไป",
            "warning"
          );
        }
      }
    },

    input_validation_check() {
      // check the status of step

      const form_step = document.querySelector(`#form_step_${this.step}`);
      const form_step_input = form_step.querySelectorAll(
        "input[required], select[required]"
      );

      // Map element IDs to their values
      // This value is for checking validation if the require is empty or not.
      const form_step_input_value = Object.fromEntries(
        Array.from(form_step_input).map((input) => [
          input.id,
          input.value.trim(),
        ])
      );

      // Add error on input
      Object.entries(form_step_input_value).forEach(([key, value]) => {
        const element = document.getElementById(`${key}`);

        if (value === "" && element) {
          element.classList.add("error");
        }

        if (element) {
          element.addEventListener("input", () => {
            if (element.value.trim() !== "") {
              element.classList.remove("error");
            }
          });
        }
      });
      if (Object.values(form_step_input_value).some((value) => value === "")) {
        return this.$refs.alertBox.showAlert(
          "กรุณากรอกข้อมูลให้ครบถ้วน",
          "warning"
        );
      } else {
        // if input lenght is not correct alert
        if (this.input_reach_lenght == false)
          return this.$refs.alertBox.showAlert(
            "กรุณากรอกข้อมูลของให้ถูกต้อง",
            "warning"
          );
        // Validation for check box in step 2
        switch (this.step) {
          case 1: {
            // GPAX check
            if (form_step_input_value.user_gpax < 1.8) {
              return this.$refs.alertBox.showAlert(
                "เกรดของคุณไม่ผ่าน",
                "warning"
              );
            } else if (
              form_step_input_value.user_gpax > 4 ||
              form_step_input_value.user_gpax < 0
            ) {
              return this.$refs.alertBox.showAlert(
                "กรุณากรอกเกรดของท่านให้ถูกต้อง",
                "warning"
              );
            }
            if (
              !this.lenght_Validation_form(
                form_step_input_value.user_gpax,
                4,
                "กรุณากรอก GPAX ของท่านให้ถูกต้อง"
              )
            )
              return;
            this.addStep();
            break;
          }
          case 2: {
            // สำหรับ ได้รับค่าใช้จ่ายในชีวิตประจำวัน
            // Get the container element
            const divFee = document.getElementById("div_fee_checkbox");
            // Get all checkboxes inside the container
            const checkboxesFee = divFee.querySelectorAll(
              'input[type="checkbox"]'
            );

            // Check if at least one checkbox is checked
            const isCheckedFee = Array.from(checkboxesFee).some(
              (checkbox) => checkbox.checked
            );

            // If none of the checkboxes are checked, alert the user
            if (!isCheckedFee) {
              divFee.classList.add("error");
              return this.$refs.alertBox.showAlert(
                "กรุณากรอกข้อมูลให้ครบถ้วน",
                "warning"
              );
            }

            // สำหรับ มีความประสงค์จะขอกู้ยืมเพื่อใช้ในการศึกษา
            // Get the container element
            const divLoan = document.getElementById("div_feeused_checkbox");
            // Get all checkboxes inside the container
            const checkboxesLoan = divLoan.querySelectorAll(
              'input[type="checkbox"]'
            );

            // Check if at least one checkbox is checked
            const isCheckedLoan = Array.from(checkboxesLoan).some(
              (checkbox) => checkbox.checked
            );

            // If none of the checkboxes are checked, alert the user
            if (!isCheckedLoan) {
              divLoan.classList.add("error");
              return this.$refs.alertBox.showAlert(
                "กรุณากรอกข้อมูลให้ครบถ้วน",
                "warning"
              );
            }

            // Public service hour check
            if (form_step_input_value.Public_Service_Number < 1) {
              return this.$refs.alertBox.showAlert(
                "ชั่วโมงจิตสาธารณะของท่านไม่ผ่าน",
                "warning"
              );
            }

            if (
              !this.lenght_Validation_form(
                form_step_input_value.user_phoneNumber,
                10,
                "กรุณากรอกหมายเลขโทรศัพท์ของท่านให้ถูกต้อง"
              )
            )
              return;

            if (
              !this.lenght_Validation_form(
                form_step_input_value.user_citizenID,
                13,
                "กรุณากรอกหมายเลขบัตรประชาชนของท่านให้ถูกต้อง"
              )
            )
              return;

            this.addStep();
            break;
          }
          case 3:
            // Phone number validation (at least 10 digits)
            if (
              !this.lenght_Validation_form(
                form_step_input_value.dad_phoneNumber,
                10,
                "กรุณากรอกหมายเลขโทรศัพท์บิดาของท่านให้ถูกต้อง"
              )
            )
              return;
            if (
              !this.lenght_Validation_form(
                form_step_input_value.mom_phoneNumber,
                10,
                "กรุณากรอกหมายเลขโทรศัพท์มารดาของท่านให้ถูกต้อง"
              )
            )
              return;
            if (
              !this.lenght_Validation_form(
                form_step_input_value.other_phoneNumber,
                10,
                "กรุณากรอกหมายเลขโทรศัพท์ผู้ปกครองของท่านให้ถูกต้อง"
              )
            )
              return;

            // Citizen ID validation (at least 13 digits)
            if (
              !this.lenght_Validation_form(
                form_step_input_value.dad_citizenID,
                13,
                "กรุณากรอกหมายเลขบัตรประชาชนบิดาของท่านให้ถูกต้อง"
              )
            )
              return;
            if (
              !this.lenght_Validation_form(
                form_step_input_value.mom_citizenID,
                13,
                "กรุณากรอกหมายเลขบัตรประชาชนมารดาของท่านให้ถูกต้อง"
              )
            )
              return;
            if (
              !this.lenght_Validation_form(
                form_step_input_value.other_citizenID,
                13,
                "กรุณากรอกหมายเลขบัตรประชาชนผู้ปกครองของท่านให้ถูกต้อง"
              )
            )
              return;
            this.addStep();
            this.step_4_show_data();
            break;
          case 4:
            break;
        }
      }
    },

    validateNoLeadingZeros(event) {
      const input = event.target;

      // Remove leading zeros dynamically
      if (input.value.length > 0 && input.value.startsWith("0")) {
        input.value = input.value.replace(/^0+/, "");
      }

      // Ensure the input length does not exceed 4 digits
      if (input.value.length > 4) {
        input.value = input.value.slice(0, 4);
      }
    },

    // Remove error when change
    removeError(event) {
      const parentDiv = event.target.closest("div.mb-4");
      if (parentDiv) {
        parentDiv.classList.remove("error");
      }
    },

    step_4_show_data() {
      const formData = {};

      document
        .querySelectorAll(
          "#LoanForm input, #LoanForm select, #LoanForm textarea"
        )
        .forEach((field) => {
          if (field.type === "checkbox") {
            if (!formData[field.name]) {
              formData[field.name] = [];
            }
            if (field.checked) {
              formData[field.name].push(field.value);
              const step4Element = document.getElementById(`step4_${field.id}`);
              if (step4Element) {
                step4Element.checked = true;
              }
            } else {
              const step4Element = document.getElementById(`step4_${field.id}`);
              if (step4Element) {
                step4Element.checked = false;
              }
            }
          } else if (field.type === "file") {
            if (field.files && field.files.length > 0) {
              formData[field.id] = field.files[0]; // Assign the actual file object
            } else {
              formData[field.id] = null; // No file selected
            }
          } else if (field.id) {
            formData[field.id] = field.value;
          }
        });

      const fileFlags = [
        { flag: this.dadFile_useOld, file: this.dadFile, name: "dad_file" },
        { flag: this.momFile_useOld, file: this.momFile, name: "mom_file" },
        {
          flag: this.otherFile_useOld,
          file: this.otherFile,
          name: "other_file",
        },
        {
          flag: this.publicFile_useOld,
          file: this.publicFile,
          name: "Public_Service_File",
        },
        {
          flag: this.maritalFile_useOld,
          file: this.maritalFile,
          name: "Marital_status_of_parents_file",
        },
        {
          flag: this.otherFile_certificate_useOld,
          file: this.otherFile_certificate,
          name: "other_NonParent_Custody_Certificate_file",
        },
        {
          flag: this.dad_death_certificate_file_useOld,
          file: this.dad_death_certificate_file,
          name: "dad_death_certificate_file",
        },
        {
          flag: this.mom_death_certificate_file_useOld,
          file: this.mom_death_certificate_file,
          name: "mom_death_certificate_file",
        },
        {
          flag: this.dad_family_status_certificate_file_useOld,
          file: this.dad_family_status_certificate_file,
          name: "dad_family_status_certificate_file",
        },
        {
          flag: this.mom_family_status_certificate_file_useOld,
          file: this.mom_family_status_certificate_file,
          name: "mom_family_status_certificate_file",
        },
      ];

      fileFlags.forEach((item) => {
        if (item.flag && item.file) {
          formData[`${item.name}_Old`] = item.file.path || item.file; // Check for path or file directly
        }
      });

      this.UserForm = formData;

      // Helper function to update text content
      const setText = (id, text) => {
        const element = document.getElementById(id);
        if (element) element.innerText = text;
      };

      // User info
      setText(
        "step4_user_fullname",
        `${formData.user_username} ${formData.user_surname}`
      );
      setText("step4_user_old", formData.user_old);
      setText("step4_user_phoneNumber", formData.user_phoneNumber);
      setText("step4_user_citizenID", formData.user_citizenID);

      // Study info
      const studyFields = [
        "user_lvlStudy",
        "user_yearStudy",
        "user_semesterStudy",
        "user_faculty",
        "user_fieldStudy",
        "user_studentID",
        "user_gpax",
        "user_graduateLvl",
        "Public_Service_Number",
      ];
      studyFields.forEach((field) =>
        setText(`step4_${field}`, formData[field])
      );

      // User financial info
      ["user_loanType"].forEach((field) => {
        setText(`step4_${field}`, formData[field]);
      });

      if (document.getElementById("จากการประกอบอาชีพ").checked) {
        setText("step4_user_job", formData.user_job);
        setText("step4_user_job_income", formData.user_job_income);
      }

      // Dad info
      setText(
        "step4_dad_status",
        formData.dad_status === "มีชีวิตอยู่"
          ? "มีชีวิตอยู่"
          : formData.dad_status === "เสียชีวิต"
          ? "เสียชีวิต"
          : "ไม่ทราบ"
      );

      document.getElementById("step4_dad_fullname").innerText = `${
        formData.dad_name ? formData.dad_name : "-"
      } ${formData.dad_surname ? formData.dad_surname : "-"}`;
      if (formData.dad_status === "มีชีวิตอยู่") {
        this.show_dad_info = true;
        [
          "dad_citizenID",
          "dad_phoneNumber",
          "dad_email",
          "dad_job",
          "dad_income",
        ].forEach((field) => {
          setText(`step4_${field}`, formData[field]);
        });
      }

      // Mom info
      setText(
        "step4_mom_status",
        formData.mom_status === "มีชีวิตอยู่"
          ? "มีชีวิตอยู่"
          : formData.mom_status === "เสียชีวิต"
          ? "เสียชีวิต"
          : "ไม่ทราบ"
      );

      document.getElementById("step4_mom_fullname").innerText = `${
        formData.mom_name ? formData.mom_name : "-"
      } ${formData.mom_surname ? formData.mom_surname : "-"}`;
      if (formData.mom_status === "มีชีวิตอยู่") {
        this.show_mom_info = true;
        [
          "mom_citizenID",
          "mom_phoneNumber",
          "mom_email",
          "mom_job",
          "mom_income",
        ].forEach((field) => {
          setText(`step4_${field}`, formData[field]);
        });
      }

      // Parent's marital status
      setText("step4_mariage_status", formData.Marital_status_of_parents);

      document.getElementById("step4_other_fullname").innerText = `${
        formData.other_name ? formData.other_name : "-"
      } ${formData.other_surname ? formData.other_surname : "-"}`;
      // Rightful guardian
      setText("step4_rightful_guardian", formData.rightful_guardian);
      if (formData.rightful_guardian === "ผู้ปกครองไม่ใช่บิดา มารดา") {
        this.show_other_info = true;
        [
          "other_citizenID",
          "other_phoneNumber",
          "other_email",
          "other_job",
          "other_income",
          "other_relationship",
        ].forEach((field) => {
          setText(`step4_${field}`, formData[field]);
        });
      }
    },

    // Static data
    async getEdu_lvl() {
      try {
        const response = await fetch(
          `${process.env.VUE_APP_API_BASE_URL}/user/loan/get/education_level`
        );
        if (response.ok) {
          const staticData = await response.json();
          this.setStaticData("user_lvlStudy", staticData, "level");
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

    async getFaculty() {
      try {
        const response = await fetch(
          `${process.env.VUE_APP_API_BASE_URL}/user/loan/get/faculty`
        );
        if (response.ok) {
          const staticData = await response.json();
          this.setStaticData("user_faculty", staticData, "Faculty");
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

    async getStudyField(value) {
      try {
        // Properly append the query string with a key
        const response = await fetch(
          `${
            process.env.VUE_APP_API_BASE_URL
          }/user/loan/get/fieldofstudy?faculty=${encodeURIComponent(value)}`
        );

        if (response.ok) {
          const staticData = await response.json();
          this.setStaticData("user_fieldStudy", staticData, "Field_of_study");
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

    async getGraduatedLevel() {
      try {
        // Properly append the query string with a key
        const response = await fetch(
          `${process.env.VUE_APP_API_BASE_URL}/user/loan/get/graduatedLevel`
        );
        if (response.ok) {
          const staticData = await response.json();
          this.setStaticData("user_graduateLvl", staticData, "Graduated_level");
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

    async getDailyExpensesOptions() {
      try {
        // Properly append the query string with a key
        const response = await fetch(
          `${process.env.VUE_APP_API_BASE_URL}/user/loan/get/dailyExpensesOptions`
        );
        if (response.ok) {
          const staticData = await response.json();
          this.setStaticDataCheckBox(
            "user_DailyExpenses",
            staticData,
            "category",
            "dailyFee"
          );
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

    async getLoanPurposesOptions() {
      try {
        // Properly append the query string with a key
        const response = await fetch(
          `${process.env.VUE_APP_API_BASE_URL}/user/loan/get/loanPurposesOption`
        );
        if (response.ok) {
          const staticData = await response.json();
          this.setStaticDataCheckBox(
            "user_feeused",
            staticData,
            "purpose",
            "loanPurpose"
          );
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

    async getServerStatus() {
      try {
        // Properly append the query string with a key
        const response = await fetch(
          `${process.env.VUE_APP_API_BASE_URL}/user/loan/server/status`
        );
        if (response.ok) {
          const serverStatus = await response.json();
          this.studyYear = serverStatus.study_year;
          this.studySemester = serverStatus.study_semester;
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

    async getServerStatus_kickUser() {
      try {
        // Properly append the query string with a key
        const response = await fetch(
          `${process.env.VUE_APP_API_BASE_URL}/user/loan/server/status`
        );
        if (response.ok) {
          const serverStatus = await response.json();
          if (serverStatus.server_status === "close") {
            Swal.fire({
              text: "ระบบการยื่นกู้ยังไม่เปิด ณ ขณะนี้",
              icon: "error",
              confirmButtonColor: "#964040",
            });
            return this.$router.replace("/user");
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

    async getServerStatus_editLoan() {
      try {
        // Properly append the query string with a key
        const response = await fetch(
          `${process.env.VUE_APP_API_BASE_URL}/user/loan/server/editLoan/status`
        );
        if (response.ok) {
          const serverStatus = await response.json();
          if (serverStatus.server_status === "close") {
            Swal.fire({
              text: "ระบบการแก้ไขคำขอกู้ยังไม่เปิด ณ ขณะนี้",
              icon: "error",
              confirmButtonColor: "#964040",
            });
            return this.$router.replace("/user");
          }

          if (
            this.studyYear != serverStatus.study_year ||
            this.studySemester != serverStatus.study_semester
          ) {
            Swal.fire({
              text: "คุณไม่สามารถแก้ไขคำขอกู้ได้ในปีการศึกษาหรือภาคเรียนอื่น",
              icon: "error",
              confirmButtonColor: "#964040",
            });
            return this.$router.replace("/user");
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

    async getStudentLoanLast() {
      try {
        // Properly append the query string with a key
        const response = await fetch(
          `${process.env.VUE_APP_API_BASE_URL}/user/get/loan/last`,
          {
            method: "GET",
            credentials: "include",
          }
        );
        if (response.ok) {
          const staticData = await response.json();

          if (!staticData) return;

          const sameSemesterYear =
            Number(this.studySemester) ===
              Number(staticData.user_semesterStudy) &&
            Number(this.studyYear) === Number(staticData.user_yearStudy);

          if (!sameSemesterYear) return;

          const statusMap = {
            อยู่ระหว่างดำเนินการ: {
              title: "คุณได้ทำการยื่นคำขอกู้ยืมแล้ว",
              icon: "info",
            },
            ตีกลับเพื่อแก้เอกสาร: {
              title: "กรุณาแก้ไขคำขอกู้ยืมของคุณ",
              icon: "info",
            },
            ผ่านการตรวจสอบคุณสมบัติ: {
              title: "คำขอกู้ยืมของคุณผ่านการตรวจสอบคุณสมบัติ",
              icon: "success",
            },
            อนุมัติ: {
              title: "คำขอกู้ยืมของคุณผ่านการอนุมัติ",
              icon: "success",
            },
            ไม่อนุมัติ: {
              title: "คำขอกู้ยืมของคุณไม่อนุมัติ",
              icon: "error",
            },
            อยู่ระหว่างตรวจสอบคุณสมบัติผู้กู้ยืม: {
              title: "อยู่ระหว่างตรวจสอบคุณสมบัติผู้กู้ยืม",
              icon: "info",
            },
            "รอผลการพิจารณาจากกองทุน กยศ.": {
              title: "คำขอกู้ยืมของคุณอยู่รอผลการพิจารณาจากกองทุน กยศ.",
              icon: "info",
            },
          };

          const statusData = statusMap[staticData.loan_status];
          if (statusData) {
            await Swal.fire({
              title: statusData.title,
              text: "",
              icon: statusData.icon,
              confirmButtonText: "ยืนยัน",
              confirmButtonColor: "#964040",
            });
            return this.$router.replace("/user");
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

    setStaticData(element_name, data, detail) {
      let datas = '<option disabled selected value="">กรุณาเลือก</option>';
      data.forEach((uld) => {
        datas += `<option value="${uld[detail]}">${uld[detail]}</option>`;
      });
      // Find the select element by its name or ID
      const element = document.getElementById(element_name);
      if (element) {
        element.innerHTML = datas;
      } else {
        console.error(`Element with selector "${element_name}" not found.`);
      }
    },

    setStaticDataCheckBox(element_name, data, detail, name) {
      let datas = [];
      let step4_checkbox = [];
      data.forEach((uld) => {
        datas += `<div><input type="checkbox" name="${name}" value="${uld[detail]}" id="${uld[detail]}" required/><label for="${uld[detail]}">${uld[detail]}</label></div>`;
        step4_checkbox += `<div><input disabled class="me-2" type="checkbox" id="step4_${uld[detail]}" required/><label for="${uld[detail]}">${uld[detail]}</label></div>`;
      });

      // Find the select element by its name or ID
      const element = document.getElementById(element_name);
      const step4_element = document.getElementById(`step4_${name}`);
      if (element) {
        element.innerHTML = datas;
      } else {
        console.error(`Element with selector "${element_name}" not found.`);
      }

      if (step4_element) {
        step4_element.innerHTML = step4_checkbox;
      } else {
        console.error(`Element with selector "${step4_element}" not found.`);
      }
    },

    async confirmBoxForm() {
      if (this.isSubmitting) return;

      if (this.formID) {
        const result = await Swal.fire({
          title: "คุณแน่ใจที่จะแก้ไขข้อมูลหรือไม่",
          showCancelButton: true,
          cancelButtonText: "ยกเลิก",
          confirmButtonText: "ยืนยัน",
          confirmButtonColor: "#964040",
        });

        if (result.isConfirmed) {
          this.APIeditForm();
        }
        return;
      }

      const result = await Swal.fire({
        title: "คุณแน่ใจหรือไม่",
        showCancelButton: true,
        cancelButtonText: "ยกเลิก",
        confirmButtonText: "ยืนยัน",
        confirmButtonColor: "#964040",
      });

      if (result.isConfirmed) {
        this.APIsentForm();
        // alert("ไม่สารมารถส่งคำขอกู้ได้ กรุณาแก้ไขคำขอกู้");
      }
    },

    // Session
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
          this.clearAllTimeouts();
          this.getSession();
          this.startTimer();
        }
      } catch (error) {
        console.error("Error extending session:", error);
      }
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
      this.activeTimeouts = [];
    },

    // Edit Form
    async getLoanData(value) {
      try {
        // Properly append the query string with a key
        const response = await fetch(
          `${
            process.env.VUE_APP_API_BASE_URL
          }/user/get/loan/data?id=${encodeURIComponent(value)}`,
          {
            method: "GET",
            credentials: "include", // Ensure cookies are included
          }
        );
        if (response.ok) {
          const staticData = await response.json();
          setTimeout(() => {
            this.setValueFormEdit(staticData);
          }, 500);
        } else if (response.status === 500) {
          const errorMessage = await response.text();
          this.$router.replace("/user");
          throw new Error(errorMessage);
        } else {
          this.$router.replace("/user");
          throw new Error("Connection error");
        }
      } catch (error) {
        console.error(error.message);
        alert(error.message);
      }
    },

    setValueFormEdit(data) {
      // Set show file
      const fileMappings = {
        Public_Service_File: "publicFile",
        dad_file: "dadFile",
        mom_file: "momFile",
        other_file: "otherFile",
        other_NonParent_Custody_Certificate_file: "otherFile_certificate",
        Marital_status_of_parents_file: "maritalFile",
        dad_death_certificate_file: "dad_death_certificate_file",
        mom_death_certificate_file: "mom_death_certificate_file",
        dad_family_status_certificate_file:
          "dad_family_status_certificate_file",
        mom_family_status_certificate_file:
          "mom_family_status_certificate_file",
      };

      Object.keys(fileMappings).forEach((key) => {
        if (data[key]) {
          this[key] = true;
          this[fileMappings[key]] = data[key];
        }
      });

      const setValue = (id, Value) => {
        const element = document.getElementById(id);
        if (element) element.value = Value;
      };

      const Step1 = [
        "user_lvlStudy",
        "user_faculty",
        "user_loanType",
        "user_gpax",
      ];

      const fieldStudyElement = document.getElementById("user_fieldStudy");
      if (fieldStudyElement) {
        fieldStudyElement.innerHTML = `<option value="${data.user_fieldStudy}" selected>${data.user_fieldStudy}</option>`;
      }

      Step1.forEach((field) => setValue(field, data[field]));

      this.studyYear = data.user_yearStudy;

      const Step2 = [
        "user_username",
        "user_surname",
        "user_old",
        "user_phoneNumber",
        "user_citizenID",
        "user_graduateLvl",
        "Public_Service_Number",
      ];

      Step2.forEach((field) => setValue(field, data[field]));

      document
        .querySelectorAll('input[name="dailyFee"]')
        .forEach((checkbox) => {
          if (
            JSON.parse(data.daily_expenses_options).includes(checkbox.value)
          ) {
            checkbox.checked = true;
          }
        });

      if (
        JSON.parse(data.daily_expenses_options).includes("จากการประกอบอาชีพ")
      ) {
        this.finance_income_checkbox = true;

        this.$nextTick(() => {
          this.user_job = data.occupation;
          this.user_job_income = data.income;
        });
      }
      document
        .querySelectorAll('input[name="loanPurpose"]')
        .forEach((checkbox) => {
          // Check if the checkbox value exists in the loan_purposes_options array
          if (data.loan_purposes_options.includes(checkbox.value)) {
            checkbox.checked = true;
          }
        });
      setValue("dad_status", data.dad_status);
      this.$nextTick(() => {
        const dadSelect = document.getElementById("dad_status");
        if (dadSelect) {
          const event = new Event("change", { bubbles: true });
          dadSelect.dispatchEvent(event);
        }
      });

      if (data.dad_status == "มีชีวิตอยู่") {
        this.showInput_dad = true;
        this.$nextTick(() => {
          setValue("dad_citizenID", data.dad_citizenID);
          setValue("dad_name", data.dad_name);
          setValue("dad_surname", data.dad_surname);
          setValue("dad_phoneNumber", data.dad_phoneNumber);
          setValue("dad_email", data.dad_email);
          setValue("dad_job", data.dad_job);
          setValue("dad_income", data.dad_income);
        });
      }

      setValue("mom_status", data.mom_status);

      this.$nextTick(() => {
        const momSelect = document.getElementById("mom_status");
        if (momSelect) {
          const event = new Event("change", { bubbles: true });
          momSelect.dispatchEvent(event);
        }
      });

      if (data.mom_status == "มีชีวิตอยู่") {
        this.showInput_mom = true;
        this.$nextTick(() => {
          setValue("mom_citizenID", data.mom_citizenID);
          setValue("mom_name", data.mom_name);
          setValue("mom_surname", data.mom_surname);
          setValue("mom_phoneNumber", data.mom_phoneNumber);
          setValue("mom_email", data.mom_email);
          setValue("mom_job", data.mom_job);
          setValue("mom_income", data.mom_income);
        });
      }

      this.Marital_status_of_parents = data.Marital_status_of_parents;
      this.$nextTick(() => {
        this.Marital_status_of_parents = data.Marital_status_of_parents;
      });

      this.selectedGuardian = data.rightful_guardian;
      if (data.rightful_guardian == "ผู้ปกครองไม่ใช่บิดา มารดา") {
        this.showInput_other = true;
        this.$nextTick(() => {
          setValue("other_citizenID", data.other_citizenID);
          setValue("other_name", data.other_name);
          setValue("other_surname", data.other_surname);
          setValue("other_phoneNumber", data.other_phoneNumber);
          setValue("other_email", data.other_email);
          setValue("other_job", data.other_job);
          setValue("other_income", data.other_income);
          setValue("other_relationship", data.other_relationship);
        });
      }
    },

    getStaticData() {
      this.getDailyExpensesOptions();
      this.getLoanPurposesOptions();
      this.getEdu_lvl();
      this.getFaculty();
      this.getGraduatedLevel();
    },

    getFileUrl(filePath) {
      if (!filePath || typeof filePath !== "string") return "#"; // Check for invalid input

      // Prevent path traversal by allowing only specific prefixes
      if (!filePath.startsWith("/uploads/")) return "#";

      const baseUrl = `${process.env.VUE_APP_API_BASE_URL}` || `localhost:3000`;

      return `${baseUrl}${filePath}`;
    },
  },

  //Use function when the component is used
  async mounted() {
    this.getSession();
    this.getServerStatus();
    await this.getStaticData();

    this.throttledResetSessionExpiration = throttle(
      this.resetSessionExpiration,
      3000
    );
    window.addEventListener("scroll", this.throttledResetSessionExpiration);

    // For edit form
    const uldId = localStorage.getItem("uldId");
    if (uldId) {
      this.formID = uldId;
      this.getLoanData(uldId);
      this.getServerStatus_editLoan();
    }
  },
  unmounted() {
    window.removeEventListener("scroll", this.throttledResetSessionExpiration);
    this.clearAllTimeouts();
  },
  beforeUnmount() {
    localStorage.removeItem("uldId");
  },
  watch: {
    selectedGuardian(newValue) {
      if (newValue === "ผู้ปกครองไม่ใช่บิดา มารดา") {
        this.showInput_other = true;
      } else {
        this.showInput_other = false;
      }
    },
    Marital_status_of_parents(newValue) {
      if (
        newValue == "ไม่ทราบ" ||
        newValue == "สมรส" ||
        newValue == "แยกทางกันโดยมิได้จดทะเบียนสมรส"
      ) {
        this.show_marriage_pdf = false;
      } else {
        this.show_marriage_pdf = true;
      }
    },
    studentID(newValue) {
      if (newValue == "6531501999") {
        Swal.fire({
          text: "เกิดข้อผิดพลาดในการดึงข้อมูลนักศึกษา",
          icon: "error",
          confirmButtonColor: "#964040",
        });
        return this.$router.push("/user");
      } else {
        this.getStaticData();
        if (!localStorage.getItem("uldId")) {
          this.getStudentLoanLast();
          this.getServerStatus_kickUser();
        }
      }
    },
  },
};
</script>

<style scoped>
/* To Make Sure h1-h6 don't have extended space */
h1,
h2,
h3,
h4,
h5,
h6 {
  margin: 0;
  padding: 0;
}

.red-circle {
  position: absolute;
  width: 100%;
  height: 40%;
  background-color: #964040;
  z-index: -1;
}

.con-header {
  color: black;
}

.screen-control {
  height: 100vh;
  min-height: 100%;
  overflow-y: auto;
}

#LoanForm {
  padding: 8vw 17vw 0vw 17vw;
}

/* For error input */
.error {
  border: 2px solid red;
  animation: shake 0.5s ease-in-out;
}
@keyframes shake {
  0% {
    transform: translateX(0);
  }
  25% {
    transform: translateX(-5px);
  }
  50% {
    transform: translateX(5px);
  }
  75% {
    transform: translateX(-5px);
  }
  100% {
    transform: translateX(0);
  }
}

/* Remove Arrow increase & decrease in input"number"*/
/* For Chrome, Safari, Edge, and Opera */
input[type="number"]::-webkit-inner-spin-button,
input[type="number"]::-webkit-outer-spin-button {
  -webkit-appearance: none;
  margin: 0;
}
/* For Firefox */
input[type="number"] {
  -moz-appearance: textfield;
}

/* ------------------------------------------------ */
/* Progress Bar */
.progress-container {
  position: fixed;
  top: 120px;
  left: 50%;
  transform: translate(-50%, -50%);
  display: flex;
  align-items: center;
  justify-content: space-between;
  width: 80%;
  height: 15%;
  padding: 5px 10vw;
  z-index: 2;
}

/* Step circles */
.progress-step {
  display: flex;
  align-items: center;
  flex-direction: column;
  height: 100px;
  width: 0%;
}

/* Circles for each step */
.step-circle {
  width: 40px;
  height: 40px;
  min-height: 40px;
  background-color: #e0e0e0;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  font-weight: bold;
  font-size: 14px;
  z-index: 2;
}

.progress-line {
  position: relative;
  width: 100vw;
  height: 2px;
  margin-bottom: 60px;
  background-color: #e0e0e0;
  z-index: 1;
}

/* Highlight line and step circle when active */
.progress-step.active .step-circle {
  background-color: #a93a3a; /* Change to the active color */
}

.progress-step.active + .progress-line {
  background-color: #a93a3a;
}

/* Step labels */
.step-label {
  font-size: 14px;
  margin-top: 1vw;
  color: #555;
  text-align: center;
  white-space: nowrap;
  text-overflow: ellipsis;

  text-shadow: -1px -1px 0 white, 1px -1px 0 white, -1px 1px 0 white,
    1px 1px 0 white;
}

.step-label.active {
  color: black;
}

/* ------------------------------------------------ */
/* Phone, tablet */
@media (max-width: 768px) or (max-height: 768px) {
  /* Adjust the breakpoint as needed */
  #LoanForm {
    padding: 13vw 0vw 0vw 0vw;
  }

  .progress-container {
    position: fixed;
    top: 120px;
    left: 50%;
    transform: translate(-50%, -50%);
    display: flex;
    align-items: center;
    justify-content: space-between;
    width: 90%;
    height: 15%;
    padding: 5px 10vw;
    z-index: 2;
  }

  /* Circles for each step */
  .step-circle {
    width: 30px;
    height: 30px;
    min-height: 30px;
    background-color: #e0e0e0;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    font-weight: bold;
    font-size: 10px;
    z-index: 2;
  }

  /* Step labels */
  .step-label {
    margin-top: 1vw;
    font-size: 10px;
    color: #555;
    text-align: center;
    white-space: nowrap;
    text-overflow: ellipsis;
  }

  /* progress line */
  .progress-line {
    position: relative;
    width: 100vw;
    height: 2px;
    margin-bottom: 70px;
    background-color: #e0e0e0;
    z-index: 1;
  }
}

@media (max-width: 425px) or (max-height: 425px) {
  /* Adjust the breakpoint as needed */
  #LoanForm {
    padding: 17vw 0vw 0vw 0vw;
  }

  .progress-container {
    position: fixed;
    top: 120px;
    left: 50%;
    transform: translate(-50%, -50%);
    display: flex;
    align-items: center;
    justify-content: space-between;
    width: 90%;
    height: 15%;
    padding: 5px 10vw;
    z-index: 2;
  }

  /* Circles for each step */
  .step-circle {
    width: 30px;
    height: 30px;
    min-height: 30px;
    background-color: #e0e0e0;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    font-weight: bold;
    font-size: 10px;
    z-index: 2;
  }

  /* Step labels */
  .step-label {
    margin-top: 1vw;
    font-size: 10px;
    color: #555;
    text-align: center;
    white-space: nowrap;
    text-overflow: ellipsis;
  }

  /* progress line */
  .progress-line {
    position: relative;
    width: 100vw;
    height: 2px;
    margin-bottom: 70px;
    background-color: #e0e0e0;
    z-index: 1;
  }
}
</style>
