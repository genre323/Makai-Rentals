import { React } from "react";
import { withFormik, Form } from "formik";
import { Card, Row, Col, Button } from "react-bootstrap";
import "../landing/Landing.css";
import PropTypes from "prop-types";

const ReservationDetails = (props) => {
  const {
    nextLabel,
    isSubmitting,
    backLabel,
    onBack,
    cantBack,
    handleSubmit,
    reservation,
  } = props;

  const options = {
    weekday: "long",
    month: "long",
    day: "numeric",
    hour: "numeric",
    minute: "2-digit",
  };

  const formattedDate = reservation.dateCheckIn.toLocaleString(
    "en-US",
    options
  );

  function formatDuration(minutes) {
    if (minutes < 60) {
      return minutes + " minutes";
    } else {
      const hours = Math.floor(minutes / 60);
      const remainingMinutes = minutes % 60;
      const hoursString = hours === 1 ? "hour" : "hours";
      const minutesString = remainingMinutes === 1 ? "minute" : "minutes";
      if (remainingMinutes === 0) {
        return hours + " " + hoursString;
      } else {
        return (
          hours +
          " " +
          hoursString +
          ", " +
          remainingMinutes +
          " " +
          minutesString
        );
      }
    }
  }

  return (
    <Card.Body>
      <Row className="mb-5 d-flex justify-content-center">
        <Col lg={10} md={10} sm={12}>
          <Form onSubmit={handleSubmit}>
            <h4 className="mb-3">Confirm your Reservation Details</h4>
            <div className="form-group mb-2">
              <h2 className="form-label">Reservation Details</h2>
              <p>Product ID: {reservation.productId}</p>
              <p>Date Check-In: {formattedDate}</p>
              <p>Rental Time: {formatDuration(reservation.rentalTime)}</p>
            </div>
            <div className="button-group">
              <Button
                type="button"
                className="btn btn-secondary float-start mt-2 listing-loki-actions"
                onClick={onBack}
                disabled={isSubmitting || cantBack}
              >
                {backLabel}
              </Button>
              <Button
                type="submit"
                className="btn btn-secondary float-end mt-2 listing-loki-actions"
                disabled={isSubmitting}
              >
                {nextLabel}
              </Button>
            </div>
          </Form>
        </Col>
      </Row>
    </Card.Body>
  );
};

export default withFormik({
  mapPropsToValues: (props) => ({
    productId: props.reservation.productId,
    dateCheckIn: props.reservation.dateCheckIn,
    rentalTime: props.reservation.rentalTime,
    chargeId: props.reservation.chargeId,
    statusId: props.reservation.statusId,
  }),
  handleSubmit: function (values, { props }) {
    props.onNext(values);
  },
})(ReservationDetails);

ReservationDetails.propTypes = {
  reservation: PropTypes.shape({
    productId: PropTypes.string.isRequired,
    dateCheckIn: PropTypes.instanceOf(Date).isRequired,
    rentalTime: PropTypes.number.isRequired,
    chargeId: PropTypes.string.isRequired,
    statusId: PropTypes.number.isRequired,
  }),

  handleSubmit: PropTypes.func.isRequired,
  isSubmitting: PropTypes.bool.isRequired,
  onNext: PropTypes.func.isRequired,
  nextLabel: PropTypes.string.isRequired,
  backLabel: PropTypes.string.isRequired,
  onBack: PropTypes.func.isRequired,
  cantBack: PropTypes.func.isRequired,
  isValid: PropTypes.bool.isRequired,
  setReservation: PropTypes.func,
  values: PropTypes.shape({
    productId: PropTypes.string.isRequired,
  }),
};
