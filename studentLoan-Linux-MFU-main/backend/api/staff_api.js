const express = require("express");
const router = express.Router();

const staff_file_download = require("./staff/staff_file_download");
const staff_loan_edit = require("./staff/staff_loan_edit");
const staff_get_loan = require("./staff/staff_get_loan");
const staff_server_control = require("./staff/staff_server_control");
const staff_user_rejected = require("./staff/staff_user_rejected");

router.use("/", staff_file_download);
router.use("/", staff_loan_edit);
router.use("/", staff_get_loan);
router.use("/", staff_server_control);
router.use("/", staff_user_rejected);

module.exports = router;
