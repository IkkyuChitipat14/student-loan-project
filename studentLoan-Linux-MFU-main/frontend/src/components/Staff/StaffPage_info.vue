<template>
  <div>
    <div>
      <AlertBox ref="alertBox" />
      <NavBar />
      <!-- UserPage content here -->
      <div id="floating-box" :class="{ 'floating-box--collapsed': !isExpanded }">
        <div id="floating-header" @click="toggleFloatingBox">
          <div class="d-flex justify-content-between align-items-center w-100">
            <div class="header-label" style="min-width: 100px">
              <span class="d-none d-md-inline text-black">สถานะการกู้:</span>
              <i class="fas fa-info-circle d-inline d-md-none" style="color: #964040"></i>
            </div>
            <div class="status-text d-none d-md-inline fw-bold px-2 rounded-2" id="info_loan_status"></div>
            <i id="toggle-arrow" style="color: #964040" class="fas fa-chevron-down"
              :class="{ rotated: isExpanded }"></i>
          </div>
        </div>

        <transition name="fold">
          <div id="floating-content" v-show="isExpanded">
            <div class="d-block d-md-none mb-2">
              <span class="fw-bold">สถานะการกู้:</span>
              <span id="info_loan_status_mobile"></span>
            </div>
            <div>
              <span class="fw-bold">ดูแลโดย:</span>
              <div id="Info_managed_by" class="mt-1"></div>
            </div>
            <div>
              <span class="fw-bold">รายละเอียด:</span>
              <div id="Info_loan_details" class="mt-1"></div>
            </div>
          </div>
        </transition>
      </div>
    </div>
    <div class="red-circle shadow"></div>
    <div class="screen-control">
      <!-- สถานะการกู้ -->
      <div class="p-3 text-black">
        <div class="bg-white shadow">
          <div class="p-2 row">
            <div class="col">
              <h5 class="my-auto p-2">ข้อมูลคำขอ</h5>
            </div>
            <div class="col-md my-auto mx-2"></div>
          </div>
          <hr style="border: none; height: 2px; background-color: black" class="p-0 m-0" />

          <!-- User Info -->
          <div class="p-3">
            <p class="text-secondary">ข้อมูลผู้กู้ยืมเงิน</p>
            <div class="p-3 bg-secondary-subtle">
              <div class="row">
                <div class="col">
                  <div class="row">
                    <p class="col"><b>ชื่อ-นามสกุล</b></p>
                    <p class="col-12 col-md" id="Info_user_fullname">-</p>
                  </div>
                </div>

                <div class="col-12 col-md">
                  <div class="row">
                    <p class="col"><b>อายุ</b></p>
                    <p class="col-12 col-md" id="Info_user_old">-</p>
                  </div>
                </div>
              </div>

              <div class="row"></div>

              <div class="row">
                <div class="col">
                  <div class="row">
                    <p class="col"><b>เบอร์โทรศัพท์เคลื่อนที่</b></p>
                    <p class="col-12 col-md" id="Info_user_phoneNumber">-</p>
                  </div>
                </div>

                <div class="col-12 col-md">
                  <div class="row">
                    <p class="col"><b>บัตรประชาชน</b></p>
                    <p class="col-12 col-md" id="Info_user_citizenID">-</p>
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
                      <p class="col-12 col-md" id="Info_user_lvlStudy">-</p>
                    </div>
                  </div>
                  <div class="col-12 col-md"></div>
                </div>

                <div class="row">
                  <div class="col">
                    <div class="row">
                      <p class="col"><b>ปีการศึกษา</b></p>
                      <p class="col-12 col-md" id="Info_user_yearStudy">-</p>
                    </div>
                  </div>

                  <div class="col-12 col-md">
                    <div class="row">
                      <p class="col"><b>ภาคเรียน</b></p>
                      <p class="col-12 col-md" id="Info_user_semesterStudy">-</p>
                    </div>
                  </div>
                </div>
              </div>

              <hr style="border: none; height: 2px; background-color: black" class="p-0 m-0" />

              <div class="p-3">
                <div class="row">
                  <div class="col">
                    <div class="row">
                      <p class="col"><b>สำนักวิชา</b></p>
                      <p class="col-12 col-md" id="Info_user_faculty">-</p>
                    </div>
                  </div>
                  <div class="col-12 col-md"></div>
                </div>

                <div class="row">
                  <div class="col">
                    <div class="row">
                      <p class="col"><b>สาขาวิชา</b></p>
                      <p class="col-12 col-md" id="Info_user_fieldStudy">-</p>
                    </div>
                  </div>

                  <div class="col-12 col-md"></div>
                </div>
              </div>

              <hr style="border: none; height: 2px; background-color: black" class="p-0 m-0" />

              <div class="p-3">
                <div class="row">
                  <div class="col">
                    <div class="row">
                      <p class="col"><b>รหัสนักศึกษา</b></p>
                      <p class="col-12 col-md" id="Info_user_studentID">-</p>
                    </div>
                  </div>
                  <div class="col-12 col-md">
                    <div class="row">
                      <p class="col"><b>GPAX</b></p>
                      <p class="col-12 col-md" id="Info_user_gpax">-</p>
                    </div>
                  </div>
                </div>
              </div>

              <hr style="border: none; height: 2px; background-color: black" class="p-0 m-0" />

              <div class="p-3">
                <div class="row">
                  <div class="col">
                    <div class="row">
                      <p class="col"><b>จบการศึกษาระดับ</b></p>
                      <p class="col-12 col-md" id="Info_user_graduateLvl">-</p>
                    </div>
                  </div>
                  <div class="col-12 col-md"></div>
                </div>
              </div>

              <hr style="border: none; height: 2px; background-color: black" class="p-0 m-0" />

              <div class="p-3">
                <div class="row">
                  <div class="col">
                    <div class="row">
                      <p class="col"><b>ชั่วโมงจิตสาธารณะ</b></p>
                      <p class="col-12 col-md" id="Info_Public_Service_Number">
                        -
                      </p>
                    </div>
                  </div>
                  <div class="col-12 col-md">
                    <div class="row">
                      <div class="col">เอกสารชั่วโมงจิตสาธารณะ</div>
                      <div class="col-12 col-md" id="Info_Public_Service_File" v-if="Public_Service_File">
                        <a :href="getFileUrl(publicFile)" target="_blank" rel="noopener noreferrer">
                          <p class="text-primary text-decoration-underline">
                            คลิ๊กเพื่อดูไฟล์
                          </p>
                        </a>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- User's fiance info -->
          <div class="p-3">
            <p class="text-secondary">ข้อมูลการเงิน</p>
            <div class="bg-secondary-subtle">
              <div class="p-3">
                <div class="row">
                  <div class="col">
                    <div class="row">
                      <p class="col"><b>ได้รับค่าใช้จ่ายในชีวิตประจำวัน</b></p>
                      <p class="col-12 col-md" id="Info_dailyFee">-</p>
                    </div>
                  </div>
                  <div class="col-12 col-md"></div>
                </div>

                <div class="row">
                  <div class="col">
                    <div class="row">
                      <p class="col"><b>อาชีพ</b></p>
                      <p class="col-12 col-md" id="Info_occupation">-</p>
                    </div>
                  </div>
                  <div class="col-12 col-md"></div>
                </div>

                <div class="row">
                  <div class="col">
                    <div class="row">
                      <p class="col"><b>รายได้บาท/ปี</b></p>
                      <p class="col-12 col-md" id="Info_income">-</p>
                    </div>
                  </div>
                  <div class="col-12 col-md"></div>
                </div>
              </div>

              <hr style="border: none; height: 2px; background-color: black" class="p-0 m-0" />

              <div class="row p-3">
                <div class="col">
                  <div class="row">
                    <p class="col">
                      <b> มีความประสงค์จะขอกู้ยืม<br />เพื่อใช้ในการศึกษา</b>
                    </p>
                    <p class="col-12 col-md" id="Info_loanPurpose">-</p>
                  </div>
                </div>
                <div class="col-12 col-md"></div>
              </div>

              <hr style="border: none; height: 2px; background-color: black" class="p-0 m-0" />

              <div class="row p-3">
                <div class="col">
                  <div class="row">
                    <p class="col"><b>ลักษณะของผู้กู้ยืม</b></p>
                    <p class="col-12 col-md" id="Info_user_loanType">-</p>
                  </div>
                </div>
                <div class="col-12 col-md" id="loanType_checkbox"></div>
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
                    <p class="col-12 col-md" id="Info_dad_status">-</p>
                  </div>
                </div>

                <div class="col-12 col-md"></div>
              </div>

              <div class="row" v-show="dad_death_certificate_file">
                <div class="col">
                  <div class="row">
                    <p class="col"><b>ใบมรณะบัตรของบิดา</b></p>
                    <div class="col-12 col-md" id="Info_dad_death_certificate_file">
                      <a :href="getFileUrl(dad_death_certificate_file)" target="_blank" rel="noopener noreferrer"
                        v-if="dad_death_certificate_file">
                        <p class="text-primary text-decoration-underline">
                          คลิ๊กเพื่อดูไฟล์
                        </p>
                      </a>
                      <p v-else>-</p>
                    </div>
                  </div>
                </div>
                <div class="col-12 col-md"></div>
              </div>

              <div class="row" v-show="dad_family_status_certificate_file">
                <div class="col">
                  <div class="row">
                    <p class="col"><b>ไฟล์หนังสือรับรองสถานะภาพครอบครัว</b></p>
                    <div class="col-12 col-md" id="Info_dad_family_status_certificate_file">
                      <a :href="getFileUrl(dad_family_status_certificate_file)" target="_blank"
                        rel="noopener noreferrer" v-if="dad_family_status_certificate_file">
                        <p class="text-primary text-decoration-underline">
                          คลิ๊กเพื่อดูไฟล์
                        </p>
                      </a>
                      <p v-else>-</p>
                    </div>
                  </div>
                </div>
                <div class="col-12 col-md"></div>
              </div>

              <div v-show="show_dad_info">
                <div class="row">
                  <div class="col">
                    <div class="row">
                      <p class="col"><b>ชื่อ-นามสกุล </b></p>
                      <p class="col-12 col-md" id="Info_dad_fullname">-</p>
                    </div>
                  </div>

                  <div class="col-12 col-md">
                    <div class="row">
                      <p class="col"><b>เลขบัตรประชาชน</b></p>
                      <p class="col-12 col-md" id="Info_dad_citizenID">-</p>
                    </div>
                  </div>
                </div>

                <div class="row">
                  <div class="col">
                    <div class="row">
                      <p class="col">
                        <b>เบอร์โทรศัพท์เคลื่อนที่</b>
                      </p>
                      <p class="col-12 col-md" id="Info_dad_phoneNumber">-</p>
                    </div>
                  </div>

                  <div class="col-12 col-md">
                    <div class="row">
                      <p class="col"><b>อีเมล</b></p>
                      <p class="col-12 col-md" id="Info_dad_email">-</p>
                    </div>
                  </div>
                </div>

                <div class="row">
                  <div class="col">
                    <div class="row">
                      <p class="col"><b>อาชีพ</b></p>
                      <p class="col-12 col-md" id="Info_dad_job">-</p>
                    </div>
                  </div>

                  <div class="col-12 col-md">
                    <div class="row">
                      <p class="col"><b>มีรายได้บาท/ปี</b></p>
                      <p class="col-12 col-md" id="Info_dad_income">-</p>
                    </div>
                  </div>
                </div>

                <div class="row">
                  <div class="col">
                    <div class="row">
                      <p class="col"><b>เอกสารรับรองรายได้ของบิดา</b></p>
                      <div class="col-12 col-md" id="Info_dad_file">
                        <a :href="getFileUrl(dadFile)" target="_blank" rel="noopener noreferrer" v-if="dadFile">
                          <p class="text-primary text-decoration-underline">
                            คลิ๊กเพื่อดูไฟล์
                          </p>
                        </a>
                        <p v-else>-</p>
                      </div>
                    </div>
                  </div>
                  <div class="col-12 col-md"></div>
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
                    <p class="col-12 col-md" id="Info_mom_status">-</p>
                  </div>
                </div>

                <div class="col"></div>
              </div>

              <div class="row" v-show="mom_death_certificate_file">
                <div class="col">
                  <div class="row">
                    <p class="col"><b>ใบมรณะบัตรของมารดา</b></p>
                    <div class="col-12 col-md" id="Info_mom_death_certificate_file">
                      <a :href="getFileUrl(mom_death_certificate_file)" target="_blank" rel="noopener noreferrer"
                        v-if="mom_death_certificate_file">
                        <p class="text-primary text-decoration-underline">
                          คลิ๊กเพื่อดูไฟล์
                        </p>
                      </a>
                      <p v-else>-</p>
                    </div>
                  </div>
                </div>
                <div class="col-12 col-md"></div>
              </div>

              <div class="row" v-show="mom_family_status_certificate_file">
                <div class="col">
                  <div class="row">
                    <p class="col"><b>หนังสือรับรองสถานะภาพครอบครัว</b></p>
                    <div class="col-12 col-md" id="Info_mom_family_status_certificate_file">
                      <a :href="getFileUrl(mom_family_status_certificate_file)" target="_blank"
                        rel="noopener noreferrer" v-if="mom_family_status_certificate_file">
                        <p class="text-primary text-decoration-underline">
                          คลิ๊กเพื่อดูไฟล์
                        </p>
                      </a>
                      <p v-else>-</p>
                    </div>
                  </div>
                </div>
                <div class="col-12 col-md"></div>
              </div>

              <div v-show="show_mom_info">
                <div class="row">
                  <div class="col">
                    <div class="row">
                      <p class="col"><b>ชื่อ-นามสกุล</b></p>
                      <p class="col-12 col-md" id="Info_mom_fullname">-</p>
                    </div>
                  </div>

                  <div class="col-12 col-md">
                    <div class="row">
                      <p class="col"><b>เลขบัตรประชาชน</b></p>
                      <p class="col-12 col-md" id="Info_mom_citizenID">-</p>
                    </div>
                  </div>
                </div>

                <div class="row">
                  <div class="col">
                    <div class="row">
                      <p class="col">
                        <b>เบอร์โทรศัพท์เคลื่อนที่ </b>
                      </p>
                      <p class="col-12 col-md" id="Info_mom_phoneNumber">-</p>
                    </div>
                  </div>

                  <div class="col-12 col-md">
                    <div class="row">
                      <p class="col"><b>อีเมล</b></p>
                      <p class="col-12 col-md" id="Info_mom_email">-</p>
                    </div>
                  </div>
                </div>

                <div class="row">
                  <div class="col">
                    <div class="row">
                      <p class="col"><b>อาชีพ</b></p>
                      <p class="col-12 col-md" id="Info_mom_job">-</p>
                    </div>
                  </div>

                  <div class="col-12 col-md">
                    <div class="row">
                      <p class="col"><b>มีรายได้บาท/ปี</b></p>
                      <p class="col-12 col-md" id="Info_mom_income">-</p>
                    </div>
                  </div>
                </div>

                <div class="row">
                  <div class="col">
                    <div class="row">
                      <p class="col"><b>เอกสารรับรองรายได้ของมารดา</b></p>
                      <div class="col-12 col-md" id="Info_mom_file">
                        <a :href="getFileUrl(momFile)" target="_blank" rel="noopener noreferrer" v-if="momFile">
                          <p class="text-primary text-decoration-underline">
                            คลิ๊กเพื่อดูไฟล์
                          </p>
                        </a>
                        <p v-else>-</p>
                      </div>
                    </div>
                  </div>
                  <div class="col-12 col-md"></div>
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
                    <p class="col-12 col-md" id="Info_mariage_status">-</p>
                  </div>
                </div>
                <div class="col"></div>
              </div>

              <div class="row" v-if="maritalFile">
                <div class="col">
                  <div class="row">
                    <p class="col"><b>เอกสาร</b></p>
                    <div class="col-12 col-md" id="Info_Marital_status_of_parents_file">
                      <a :href="getFileUrl(maritalFile)" target="_blank" rel="noopener noreferrer">
                        <p class="text-primary text-decoration-underline">
                          คลิ๊กเพื่อดูไฟล์
                        </p>
                      </a>
                    </div>
                  </div>
                </div>
                <div class="col-12 col-md"></div>
              </div>
            </div>
          </div>

          <!-- User's rightful guardian info -->
          <div class="p-3">
            <p class="text-secondary">ข้อมูลผู้แทนโดยชอบธรรม/ผู้ปกครอง</p>
            <div class="p-3 bg-secondary-subtle">
              <div class="row">
                <div class="col">
                  <div class="row">
                    <p class="col"><b>ผู้แทนโดยชอบธรรม/ผู้ปกครอง</b></p>
                    <p class="col-12 col-md" id="Info_rightful_guardian">-</p>
                  </div>
                </div>
                <div class="col-12 col-md"></div>
              </div>

              <div v-show="show_other_info">
                <div class="row">
                  <div class="col">
                    <div class="row">
                      <p class="col"><b>ชื่อ-นามสกุล</b></p>
                      <p class="col-12 col-md" id="Info_other_fullname">-</p>
                    </div>
                  </div>

                  <div class="col-12 col-md">
                    <div class="row">
                      <p class="col"><b>เลขบัตรประชาชน</b></p>
                      <p class="col-12 col-md" id="Info_other_citizenID">-</p>
                    </div>
                  </div>
                </div>

                <div class="row">
                  <div class="col">
                    <div class="row">
                      <p class="col">
                        <b>เบอร์โทรศัพท์เคลื่อนที่</b>
                      </p>
                      <p class="col-12 col-md" id="Info_other_phoneNumber">-</p>
                    </div>
                  </div>

                  <div class="col-12 col-md">
                    <div class="row">
                      <p class="col"><b>อีเมล</b></p>
                      <p class="col-12 col-md" id="Info_other_email">-</p>
                    </div>
                  </div>
                </div>

                <div class="row">
                  <div class="col">
                    <div class="row">
                      <p class="col"><b>อาชีพ</b></p>
                      <p class="col-12 col-md" id="Info_other_job">-</p>
                    </div>
                  </div>

                  <div class="col-12 col-md">
                    <div class="row">
                      <p class="col"><b>มีรายได้บาท/ปี</b></p>
                      <p class="col-12 col-md" id="Info_other_income">-</p>
                    </div>
                  </div>
                </div>

                <div class="row">
                  <div class="col">
                    <div class="row">
                      <p class="col">
                        <b>เอกสารรับรองรายได้ของผู้แทนโดยชอบธรรม/ผู้ปกครอง</b>
                      </p>
                      <div class="col-12 col-md" id="Info_other_file">
                        <a :href="getFileUrl(otherFile)" target="_blank" rel="noopener noreferrer" v-if="otherFile">
                          <p class="text-primary text-decoration-underline">
                            คลิ๊กเพื่อดูไฟล์
                          </p>
                        </a>
                        <p v-else>-</p>
                      </div>
                    </div>
                  </div>
                  <div class="col-12 col-md">
                    <div class="row">
                      <p class="col">
                        <b>หนังสือรับรองการเป็นผู้อุปการะที่ไม่ใช่บิดา-มารดา</b>
                      </p>
                      <div class="col-12 col-md" id="Info_other_file">
                        <a :href="getFileUrl(otherFile_certificate)" target="_blank" rel="noopener noreferrer"
                          v-if="otherFile_certificate">
                          <p class="text-primary text-decoration-underline">
                            คลิ๊กเพื่อดูไฟล์
                          </p>
                        </a>
                        <p v-else>-</p>
                      </div>
                    </div>
                  </div>
                </div>

                <div class="row">
                  <div class="col">
                    <div class="row">
                      <p class="col-3"><b>ความสัมพันธ์</b></p>
                      <p class="col-12 col-md" id="Info_other_relationship">-</p>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="float-end p-3">
            <button class="btn btn-primary shadow" @click="confirmBoxWithValue">
              เปลี่ยนสถานะคำข้อกู้
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import NavBar from "@/components/Staff/NavBar_staff.vue";
import AlertBox from "../AlertBox.vue";
import Swal from "sweetalert2";

export default {
  name: "StaffPage_info",
  components: {
    NavBar,
    AlertBox,
  },

  data() {
    return {
      ID: "",
      isExpanded: false,
      show_dad_info: false,
      show_mom_info: false,
      show_other_info: false,
      Public_Service_File: false,

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
    };
  },

  methods: {
    async getLoanData(value) {
      try {
        // Properly append the query string with a key
        const response = await fetch(
          `${process.env.VUE_APP_API_BASE_URL
          }/staff/get/loan/data?id=${encodeURIComponent(value)}`,
          {
            method: "GET",
            credentials: "include",
          }
        );
        if (response.ok) {
          const staticData = await response.json();
          this.Info_show_data(staticData);
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

    Info_show_data(datas) {
      const formData = datas;
      console.log(formData);

      // Helper function to update text content
      const setText = (id, text) => {
        const element = document.getElementById(id);
        if (element) element.innerText = text;
      };

      const setStatus = document.getElementById("info_loan_status");
      // show loan status
      const statusClassMap = {
        อยู่ระหว่างดำเนินการ: "style='color: orange;'",
        ผ่านการตรวจสอบคุณสมบัติ: "class='text-success'",
        อยู่ระหว่างตรวจสอบคุณสมบัติผู้กู้ยืม: "class='text-secondary'",
        "รอผลการพิจารณาจากกองทุน กยศ.": "class='text-warning'",
        ตีกลับเพื่อแก้เอกสาร: "class='text-primary'",
        อนุมัติ: "style='color: #00cc44;'",
        ไม่อนุมัติ: "class='text-danger'",
      };

      const statusText = formData.loan_status;
      const loanStatusAttr = statusClassMap[statusText] || "";

      setStatus.innerHTML = `<p class="my-auto m-0" ${loanStatusAttr}>${statusText}</p>`;

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
        if (formData[key]) {
          this[key] = true;
          this[fileMappings[key]] = formData[key];
        }
      });

      setText("Info_managed_by", formData.managed_by);
      setText("Info_loan_details", formData.loan_details);

      // User info
      setText(
        "Info_user_fullname",
        `${formData.user_username} ${formData.user_surname}`
      );
      setText("Info_user_old", formData.user_old);
      setText("Info_user_phoneNumber", formData.user_phoneNumber);
      setText("Info_user_citizenID", formData.user_citizenID);

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
      ];
      // User financial info
      let total_income = 0;
      if (formData.income) {
        total_income += parseFloat(formData.income);
      }
      if (formData.dad_income) {
        total_income += parseFloat(formData.dad_income);
      }
      if (formData.mom_income) {
        total_income += parseFloat(formData.mom_income);
      }
      if (formData.other_income) {
        total_income += parseFloat(formData.other_income);
      }

      let loanType_checkbox = "";
      ["user_loanType"].forEach((field) => {
        setText(`Info_${field}`, formData[field]);
      });
      if (formData.user_loanType == "ลักษณะที่1") {
        if (total_income > 360000) {
          loanType_checkbox += `<div><input type="checkbox" disabled>กู้ค่าครองชีพ</input></div>`;
          loanType_checkbox += `<div><input type="checkbox" disabled>กู้ยืมค่าเล่าเรียน</input></div>`;
          loanType_checkbox += `<div><input type="checkbox" disabled>ค่าใช้จ่ายเกี่ยวเนื่องกับการศึกษา</input></div>`;
        } else {
          loanType_checkbox += `<div><input type="checkbox" checked disabled>กู้ค่าครองชีพ</input></div>`;
          loanType_checkbox += `<div><input type="checkbox" checked disabled>กู้ยืมค่าเล่าเรียน</input></div>`;
          loanType_checkbox += `<div><input type="checkbox" checked disabled>ค่าใช้จ่ายเกี่ยวเนื่องกับการศึกษา</input></div>`;
        }
      } else {
        if (total_income > 360000) {
          loanType_checkbox += `<div><input type="checkbox" disabled>กู้ค่าครองชีพ</input></div>`;
          loanType_checkbox += `<div><input type="checkbox" checked disabled>กู้ยืมค่าเล่าเรียน</input></div>`;
          loanType_checkbox += `<div><input type="checkbox" checked disabled>ค่าใช้จ่ายเกี่ยวเนื่องกับการศึกษา</input></div>`;
        } else {
          loanType_checkbox += `<div><input type="checkbox" checked checked disabled>กู้ค่าครองชีพ</input></div>`;
          loanType_checkbox += `<div><input type="checkbox" checked disabled>กู้ยืมค่าเล่าเรียน</input></div>`;
          loanType_checkbox += `<div><input type="checkbox" checked disabled>ค่าใช้จ่ายเกี่ยวเนื่องกับการศึกษา</input></div>`;
        }
      }
      document.getElementById("loanType_checkbox").innerHTML =
        loanType_checkbox;

      setText(
        "Info_Public_Service_Number",
        `${formData.Public_Service_Number} ชั่วโมง`
      );

      let dailyExpensesOptions = JSON.parse(formData.daily_expenses_options);
      let daily_option = "";
      dailyExpensesOptions.forEach((option) => {
        daily_option += `<p class='m-0'>${option}</p>`;
      });
      document.getElementById(`Info_dailyFee`).innerHTML = daily_option;
      setText("Info_occupation", `${formData.occupation ?? "-"}`);
      setText("Info_income", `${formData.income ?? "-"}`);

      let loanPurposeOptions = JSON.parse(formData.loan_purposes_options);
      let purpose_option = "";
      loanPurposeOptions.forEach((option) => {
        purpose_option += `<p class='m-0'>${option}</p>`;
      });
      document.getElementById(`Info_loanPurpose`).innerHTML = purpose_option;

      studyFields.forEach((field) => setText(`Info_${field}`, formData[field]));
      // Dad info
      setText(
        "Info_dad_status",
        formData.dad_status === "มีชีวิตอยู่"
          ? "มีชีวิตอยู่"
          : formData.dad_status === "เสียชีวิต"
            ? "เสียชีวิต"
            : "ไม่ทราบ"
      );

      if (formData.dad_status === "มีชีวิตอยู่") {
        setText(
          "Info_dad_fullname",
          `${formData.dad_name} ${formData.dad_surname}`
        );
        this.show_dad_info = true;
        [
          "dad_citizenID",
          "dad_phoneNumber",
          "dad_email",
          "dad_job",
          "dad_income",
        ].forEach((field) => {
          setText(`Info_${field}`, formData[field]);
        });
      }

      // Mom info
      setText(
        "Info_mom_status",
        formData.mom_status === "มีชีวิตอยู่"
          ? "มีชีวิตอยู่"
          : formData.mom_status === "เสียชีวิต"
            ? "เสียชีวิต"
            : "ไม่ทราบ"
      );

      if (formData.mom_status === "มีชีวิตอยู่") {
        this.show_mom_info = true;
        setText(
          "Info_mom_fullname",
          `${formData.mom_name} ${formData.mom_surname}`
        );
        [
          "mom_citizenID",
          "mom_phoneNumber",
          "mom_email",
          "mom_job",
          "mom_income",
        ].forEach((field) => {
          setText(`Info_${field}`, formData[field]);
        });
      }

      // Parent's marital status
      setText("Info_mariage_status", formData.Marital_status_of_parents);

      // Rightful guardian
      setText("Info_rightful_guardian", formData.rightful_guardian);
      if (formData.rightful_guardian === "ผู้ปกครองไม่ใช่บิดา มารดา") {
        this.show_other_info = true;
        setText(
          "Info_other_fullname",
          `${formData.other_name} ${formData.other_surname}`
        );
        [
          "other_citizenID",
          "other_phoneNumber",
          "other_email",
          "other_job",
          "other_income",
          "other_relationship",
        ].forEach((field) => {
          setText(`Info_${field}`, formData[field]);
        });
      }
    },

    getFileUrl(filePath) {
      if (!filePath || typeof filePath !== "string") return "#"; // Check for invalid input

      // Prevent path traversal by allowing only specific prefixes
      if (!filePath.startsWith("/uploads/")) return "#";

      // Use a dynamic base URL (e.g., from an environment variable)
      const baseUrl = `${process.env.VUE_APP_API_BASE_URL}` || `localhost:8080`;

      return `${baseUrl}${filePath}`;
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
          console.log(this.ID);

          this.postBulkEditLoanStatus(this.ID, status, reason);
        }
      });
    },

    async postBulkEditLoanStatus(idArray, newStatus, reason = "") {
      // convert to Array (only this page!)
      if (!Array.isArray(idArray)) {
        idArray = [idArray];
      }

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
        ${failureLines.length > 0
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

          this.getLoanData(this.ID); // Refresh table
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

    toggleFloatingBox() {
      this.isExpanded = !this.isExpanded;

      // Sync mobile status display
      document.getElementById("info_loan_status_mobile").innerText =
        document.getElementById("info_loan_status").innerText;
    },
  },

  mounted() {
    const queryId = this.$route.query.id;
    if (queryId) {
      this.ID = queryId;
      this.getLoanData(queryId);
    } else {
      this.$router.replace("/user");
    }
  },

  beforeUnmount() { },

  watch() { },
};
</script>

<style scoped>
.red-circle {
  position: absolute;
  width: 100%;
  height: 40%;
  background-color: #964040;
  z-index: -1;
}

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
  padding: 5rem 20vw;
}

#floating-box {
  position: fixed;
  bottom: 20px;
  right: 20px;
  width: 320px;
  background-color: #f8f9fa;
  border: 1px solid #ccc;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
  border-radius: 10px;
  font-family: sans-serif;
  z-index: 9999;
  overflow: hidden;
  transition: all 0.3s ease;
}

#floating-header {
  background-color: #e1e1e1;
  color: white;
  padding: 10px 15px;
  cursor: pointer;
  border-top-left-radius: 10px;
  border-top-right-radius: 10px;
}

#floating-content {
  padding: 10px 15px;
  background-color: #fff;
  font-size: 0.95rem;
  word-wrap: break-word;
}

/* Fold arrow rotation */
#toggle-arrow {
  transition: transform 0.3s ease;
}

#toggle-arrow.rotated {
  transform: rotate(180deg);
}

/* Fold transition */
.fold-enter-active,
.fold-leave-active {
  transition: all 0.3s ease;
  overflow: hidden;
}

.fold-enter-from,
.fold-leave-to {
  max-height: 0;
  opacity: 0;
}

.fold-enter-to,
.fold-leave-from {
  max-height: 500px;
  opacity: 1;
}

/* Responsive behavior */
@media (max-width: 768px) {
  .screen-control {
    padding: 5rem 5vw;
  }

  #floating-box {
    right: 5%;
    bottom: 20px;
    width: 40px;
    height: 40px;
    padding: 0;
    border-radius: 50%;
    overflow: hidden;
    transition: all 0.3s ease;
  }

  #floating-box.floating-box--collapsed #floating-header {
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 0;
    height: 100%;
  }

  #floating-box.floating-box--collapsed .header-label,
  #floating-box.floating-box--collapsed .status-text {
    display: none !important;
  }

  #floating-box.floating-box--collapsed #toggle-arrow {
    margin-left: 11px;
  }

  #floating-box:not(.floating-box--collapsed) {
    width: 90%;
    height: auto;
    border-radius: 10px;
  }

  #floating-header {
    padding: 10px;
    height: auto;
    display: flex;
    align-items: center;
  }
}
</style>
