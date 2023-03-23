import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import debug from "sabio-debug";
import reservationService from "services/reservationService";
import { BsWatch, BsCheckCircleFill, BsPinMapFill } from "react-icons/bs";
import { Card, Row, Col, Container } from "react-bootstrap";
import { FaSnowboarding } from "react-icons/fa";
import Loki from "react-loki";
import ProductSelection from "./ProductSelection";
import Reservations from "./Reservations";
import ReservationDetails from "./ReservationDetails";
import StandSelection from "./StandSelection";
import Swal from "sweetalert2";
import { v4 as uuidv4 } from "uuid";
import "./reservationwizardstyles.css";

function ReservationsWizard() {
  const _logger = debug.extend("ReservationsWizard.jsx");
  const navigate = useNavigate();

  const currentDate = new Date();
  currentDate.setHours(new Date().getHours());
  currentDate.setMinutes(new Date().getMinutes());

  const [reservation, setReservation] = useState({
    productId: "",
    dateCheckIn: currentDate,
    rentalTime: "",
    chargeId: uuidv4(),
    statusId: 1,
  });

  const mergeValues = (values) => {
    setReservation((prevState) => {
      let res = { ...prevState, ...values };
      return res;
    });
  };

  const onSubmit = () => {
    const payload = {
      productId: reservation.productId,
      dateCheckIn: reservation.dateCheckIn,
      rentalTime: reservation.rentalTime,
      chargeId: reservation.chargeId,
      statusId: reservation.statusId,
    };
    _logger("OnSubmit button");
    reservationService
      .addReservation(payload)
      .then(onSubmitSuccess)
      .catch(onSubmitError);
  };

  const onSubmitSuccess = (response) => {
    _logger(response);
    Swal.fire(
      "Reservation Created!",
      "Redirecting back to home page.",
      "success",
      { button: "Ok" }
    ).then;
    navigate("/");
  };

  const onSubmitError = (error) => {
    toastr.error(error);
  };

  const customSteps = [
    {
      label: "Select Stand Location",
      icon: <BsPinMapFill />,
      component: <StandSelection reservation={reservation} />,
    },
    {
      label: "Select a Product",
      icon: <FaSnowboarding />,
      component: <ProductSelection reservation={reservation} />,
    },
    {
      label: "Select Check-In Date & Time",
      icon: <BsWatch />,
      component: <Reservations reservation={reservation} />,
    },
    {
      label: "Confirm Reservation Details",
      icon: <BsCheckCircleFill />,
      component: <ReservationDetails reservation={reservation} />,
    },
  ];

  return (
    <Container className="mt-3">
      <Card>
        <Card.Header>
          <div className="mb-3 mb-lg-0 ">
            <h2 className="fw-bold">Reservation</h2>
          </div>
        </Card.Header>
        <Card.Body>
          <Row className="mb-5">
            <Col lg={12} md={12} sm={12}>
              <Loki
                steps={customSteps}
                onNext={mergeValues}
                onBack={mergeValues}
                onFinish={onSubmit}
                backLabel={"Back"}
                nextLabel={"Next"}
                noActions
              />
            </Col>
          </Row>
        </Card.Body>
      </Card>
    </Container>
  );
}
export default ReservationsWizard;
