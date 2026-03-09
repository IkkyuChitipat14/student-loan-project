<template>
  <div>
    <NavBar :studentID="studentID" />
    <!-- UserPage content here -->
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
          <div class="col-md my-auto mx-2">
            <div class="row">
              <div class="col-auto">
                <p class="m-0">สถานะการกู้:</p>
              </div>
              <div class="col fw-bolder" id="info_loan_status"></div>
            </div>
          </div>
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

            <hr
              style="border: none; height: 2px; background-color: black"
              class="p-0 m-0"
            />

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

            <hr
              style="border: none; height: 2px; background-color: black"
              class="p-0 m-0"
            />

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

            <hr
              style="border: none; height: 2px; background-color: black"
              class="p-0 m-0"
            />

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

            <hr
              style="border: none; height: 2px; background-color: black"
              class="p-0 m-0"
            />

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
                    <div
                      class="col-12 col-md"
                      id="Info_Public_Service_File"
                      v-if="Public_Service_File"
                    >
                      <a
                        :href="getFileUrl(publicFile)"
                        target="_blank"
                        rel="noopener noreferrer"
                      >
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

            <hr
              style="border: none; height: 2px; background-color: black"
              class="p-0 m-0"
            />

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

            <hr
              style="border: none; height: 2px; background-color: black"
              class="p-0 m-0"
            />

            <div class="row p-3">
              <div class="col">
                <div class="row">
                  <p class="col"><b>ลักษณะของผู้กู้ยืม</b></p>
                  <p class="col-12 col-md" id="Info_user_loanType">-</p>
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
                  <p class="col-12 col-md" id="Info_dad_status">-</p>
                </div>
              </div>
              <div class="col-12 col-md"></div>
            </div>

            <div class="row" v-show="dad_death_certificate_file">
              <div class="col">
                <div class="row">
                  <p class="col"><b>ใบมรณะบัตรของบิดา</b></p>
                  <div
                    class="col-12 col-md"
                    id="Info_dad_death_certificate_file"
                  >
                    <a
                      :href="getFileUrl(dad_death_certificate_file)"
                      target="_blank"
                      rel="noopener noreferrer"
                      v-if="dad_death_certificate_file"
                      ><p class="text-primary text-decoration-underline">
                        คลิ๊กเพื่อดูไฟล์
                      </p></a
                    >
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
                  <div
                    class="col-12 col-md"
                    id="Info_dad_family_status_certificate_file"
                  >
                    <a
                      :href="getFileUrl(dad_family_status_certificate_file)"
                      target="_blank"
                      rel="noopener noreferrer"
                      v-if="dad_family_status_certificate_file"
                      ><p class="text-primary text-decoration-underline">
                        คลิ๊กเพื่อดูไฟล์
                      </p></a
                    >
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
                      <a
                        :href="getFileUrl(dadFile)"
                        target="_blank"
                        rel="noopener noreferrer"
                        v-if="dadFile"
                        ><p class="text-primary text-decoration-underline">
                          คลิ๊กเพื่อดูไฟล์
                        </p></a
                      >
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
                  <div
                    class="col-12 col-md"
                    id="Info_mom_death_certificate_file"
                  >
                    <a
                      :href="getFileUrl(mom_death_certificate_file)"
                      target="_blank"
                      rel="noopener noreferrer"
                      v-if="mom_death_certificate_file"
                      ><p class="text-primary text-decoration-underline">
                        คลิ๊กเพื่อดูไฟล์
                      </p></a
                    >
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
                  <div
                    class="col-12 col-md"
                    id="Info_mom_family_status_certificate_file"
                  >
                    <a
                      :href="getFileUrl(mom_family_status_certificate_file)"
                      target="_blank"
                      rel="noopener noreferrer"
                      v-if="mom_family_status_certificate_file"
                      ><p class="text-primary text-decoration-underline">
                        คลิ๊กเพื่อดูไฟล์
                      </p></a
                    >
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
                      <a
                        :href="getFileUrl(momFile)"
                        target="_blank"
                        rel="noopener noreferrer"
                        v-if="momFile"
                        ><p class="text-primary text-decoration-underline">
                          คลิ๊กเพื่อดูไฟล์
                        </p></a
                      >
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
                  <div
                    class="col-12 col-md"
                    id="Info_Marital_status_of_parents_file"
                  >
                    <a
                      :href="getFileUrl(maritalFile)"
                      target="_blank"
                      rel="noopener noreferrer"
                      ><p class="text-primary text-decoration-underline">
                        คลิ๊กเพื่อดูไฟล์
                      </p></a
                    >
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
                      <a
                        :href="getFileUrl(otherFile)"
                        target="_blank"
                        rel="noopener noreferrer"
                        v-if="otherFile"
                        ><p class="text-primary text-decoration-underline">
                          คลิ๊กเพื่อดูไฟล์
                        </p></a
                      >
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
                      <a
                        :href="getFileUrl(otherFile_certificate)"
                        target="_blank"
                        rel="noopener noreferrer"
                        v-if="otherFile_certificate"
                        ><p class="text-primary text-decoration-underline">
                          คลิ๊กเพื่อดูไฟล์
                        </p></a
                      >
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
      </div>
    </div>

    <!-- Approve Box -->
    <div class="p-3 text-black" v-if="loan_status_apporve">
      <div class="bg-white shadow">
        <div class="p-2 row">
          <div class="col">
            <h5 class="my-auto p-2">ขั้นตอนต่อไปที่ต้องดำเนินการ</h5>
          </div>
        </div>
        <hr
          style="border: none; height: 2px; background-color: black"
          class="p-0 m-0"
        />

        <div class="p-3">
          <div class="p-3 bg-secondary-subtle">
            <ul>
              <li>① ลงทะเบียนเรียนและชำระค่าธรรมเนียมการศึกษา</li>
              <li>
                ②ยืนยันค่าเล่าเรียน/ค่าใช้จ่ายเกี่ยวเนื่องกับการศึกษา/ค่าครองชีพผ่านแอพ
                กยศ. connect
              </li>
              <li>③ส่งแบบยืนยันการเบิกเงิน และเอกสารประกอบที่ห้อง กยศ. มฟล.</li>
              <li>④ การกู้ยืมเงินสำเร็จ</li>
            </ul>
          </div>
        </div>

        <div class="row"></div>
      </div>
    </div>
  </div>
</template>

<script>
import NavBar from "@/components/User/NavBar_user.vue";
import Swal from "sweetalert2";
import { throttle } from "lodash";

export default {
  name: "UserPage_info",
  components: {
    NavBar,
  },

  data() {
    return {
      ID: "",
      studentID: "6531501999",
      show_dad_info: false,
      show_mom_info: false,
      show_other_info: false,

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

      loan_status_apporve: false,

      timeoutId: null, // Add timeoutId for session timeout
      timeoutInMS: null, // Timeout duration (15 minutes) 15 x 60 x 1000 = 60000
      timeoutWarningId: null,
      warningTimeInMS: null, // 5 mins
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

    async getLoanData(value) {
      try {
        // Properly append the query string with a key
        const response = await fetch(
          `${
            process.env.VUE_APP_API_BASE_URL
          }/user/get/loan/data?id=${encodeURIComponent(value)}`,
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

    Info_show_data(datas) {
      const formData = datas;

      const setStatus = document.getElementById("info_loan_status");
      // show loan status
      switch (formData.loan_status) {
        case "อยู่ระหว่างดำเนินการ":
          setStatus.innerHTML = `<p style="color: orange;" class="my-auto m-0">${formData.loan_status}</p>`;
          break;
        case "ผ่านการตรวจสอบคุณสมบัติ":
          setStatus.innerHTML = `<p class="text-success my-auto m-0">${formData.loan_status}</p>`;
          this.loan_status_apporve = true;
          Swal.fire({
            title: "ส่งแบบคำขอกู้สำเร็จ",
            html: `
              <div class="text-start p-4">
                <ul>
                  <li>ขั้นตอนต่อไปที่ต้องดำเนินการ </li>
                  <li>① ลงทะเบียนเรียนและชำระค่าธรรมเนียมการศึกษา </li>
                  <li>② ยืนยันค่าเล่าเรียน/ค่าใช้จ่ายเกี่ยวเนื่องกับการศึกษา/ค่าครองชีพผ่านแอพ กยศ. connect  </li>
                  <li>③ ส่งแบบยืนยันการเบิกเงิน และเอกสารประกอบที่ห้อง กยศ. มฟล. 
                  </li>
                  <li>④ การกู้ยืมเงินสำเร็จ</li>
                </ul>
              </div>
            `,
            confirmButtonText: "เข้าใจแล้ว",
            confirmButtonColor: "#964040",
          });
          break;
        case "อยู่ระหว่างตรวจสอบคุณสมบัติผู้กู้ยืม":
          setStatus.innerHTML = `<p class="text-secondary my-auto m-0">${formData.loan_status}</p>`;
          break;
        case "รอผลการพิจารณาจากกองทุน กยศ.":
          setStatus.innerHTML = `<p class="text-warning my-auto m-0">${formData.loan_status}</p>`;
          break;
        case "ตีกลับเพื่อแก้เอกสาร":
          setStatus.innerHTML = `<p class="text-primary my-auto m-0">${formData.loan_status}</p>`;
          break;
        case "อนุมัติ":
          setStatus.innerHTML = `<p class="my-auto m-0" style='color: #00cc44;'>${formData.loan_status}</p>`;
          break;
        case "ไม่อนุมัติ":
          setStatus.innerHTML = `<p class="text-danger my-auto m-0">${formData.loan_status}</p>`;
          break;
        default:
          break;
      }

      // Helper function to update text content
      const setText = (id, text) => {
        const element = document.getElementById(id);
        if (element) element.innerText = text ? text : "-";
      };

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
      ["user_loanType"].forEach((field) => {
        setText(`Info_${field}`, formData[field]);
      });
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

      let loanPurposeOptions = JSON.parse(formData.loan_purposes_options);
      let purpose_option = "";
      loanPurposeOptions.forEach((option) => {
        purpose_option += `<p class='m-0'>${option}</p>`;
      });
      setText("Info_occupation", `${formData.occupation ?? "-"}`);
      setText("Info_income", `${formData.income ?? "-"}`);

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

      const baseUrl = `${process.env.VUE_APP_API_BASE_URL}` || `localhost:3000`;

      return `${baseUrl}${filePath}`;
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
          this.clearAllTimeouts();
          this.getSession();
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
  },

  mounted() {
    this.getSession();
    this.throttledResetSessionExpiration = throttle(
      this.resetSessionExpiration,
      3000
    );
    window.addEventListener("scroll", this.throttledResetSessionExpiration);
    // Retrieve `uld.id` from localStorage
    const queryId = this.$route.query.id;
    if (queryId) {
      this.ID = queryId;
      this.getLoanData(queryId);
    } else {
      this.$router.replace("/user");
    }
  },

  unmounted() {
    window.removeEventListener("scroll", this.throttledResetSessionExpiration);
    this.clearAllTimeouts();

    // Clear specific timeouts if they exist
    if (this.timeoutId) {
      clearTimeout(this.timseoutId);
      this.timeoutId = null;
    }
    if (this.timeoutWarningId) {
      clearTimeout(this.timeoutWarningId);
      this.timeoutWarningId = null;
    }
  },

  beforeUnmount() {
    localStorage.removeItem("uldId");
  },
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

.reflective-green {
  color: #39ff14; /* เขียวนีออน */
  text-shadow: 0 0 5px #39ff14, 0 0 10px #39ff14, 0 0 20px #39ff14,
    0 0 40px #0f0;
  font-weight: bold;
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
@media (max-width: 768px) {
  .screen-control {
    padding: 5rem 2vw;
  }
}
</style>
