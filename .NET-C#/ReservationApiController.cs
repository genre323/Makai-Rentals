using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Build.Framework;
using Microsoft.Extensions.Logging;
using Makai.Models;
using Makai.Models.Domain.Reservations;
using Makai.Models.Requests;
using Makai.Models.Requests.Reservations;
using Makai.Services;
using Makai.Services.Interfaces;
using Makai.Web.Controllers;
using Makai.Web.Models.Responses;
using System;
using System.Data.SqlClient;

namespace Makai.Web.Api.Controllers.Reservations
{
    [Route("api/reservations")]
    [ApiController]
    public class ReservationApiController : BaseApiController
    {
        private IReservationService _service = null;
        private IAuthenticationService<int> _authService = null;

        public ReservationApiController(IReservationService service, ILogger<ReservationApiController> logger
            , IAuthenticationService<int> authService) : base(logger)
        {
            _service = service;
            _authService = authService;
        }

        [HttpPost]
        public ActionResult<ItemResponse<int>> Add(ReservationAddRequest model)
        {
            ObjectResult result = null;
            int userId = _authService.GetCurrentUserId();

            try
            {
                int id = _service.Add(model, userId); 
                ItemResponse<int> response = new ItemResponse<int> { Item = id };
                result = Created201(response);
            }
            catch (Exception ex)
            {
                base.Logger.LogError(ex.ToString());
                ErrorResponse response = new ErrorResponse(ex.Message);

                result = StatusCode(500, response);
            }
            return result;
        }

        [HttpGet] 
        public ActionResult<ItemResponse<Paged<Reservation>>> GetPaginated(int pageIndex, int pageSize)
        {
            int code = 200;
            BaseResponse response = null;

            try
            {
                Paged<Reservation> page = _service.GetPaginated(pageIndex, pageSize);
                if (page == null)
                {
                    code = 404;
                    response = new ErrorResponse("No reservations were found.");
                }
                else
                {
                    response = new ItemResponse<Paged<Reservation>> { Item = page };
                }
            }
            catch (Exception ex)
            {
                code = 500;
                response = new ErrorResponse(ex.Message);
                base.Logger.LogError(ex.ToString());
            }
            return StatusCode(code, response);
        }

        [HttpGet("{id:int}")] 
        public ActionResult<ItemResponse<Reservation>> GetById(int id)
        {
            int code = 200;
            BaseResponse response = null;

            try
            {
                Reservation reservation = _service.GetById(id);

                if(reservation == null)
                {
                    code = 404;
                    response = new ErrorResponse("Reservation not found.");
                }
                else
                {
                    response = new ItemResponse<Reservation> { Item = reservation };
                }
            }
            catch (Exception ex)
            {
                code = 500;
                response = new ErrorResponse($"{ex.Message}");
                Logger.LogError(ex.ToString());
            }
            return StatusCode(code, response);
        }

        [HttpGet("createdby")] 
        public ActionResult<ItemResponse<Paged<Reservation>>> GetByCreatedBy(int pageIndex, int pageSize)
        {
            int code = 200;
            BaseResponse response = null;
            int creator = _authService.GetCurrentUserId();

            try
            {
                Paged<Reservation> page = _service.GetByCreatedBy(pageIndex, pageSize, creator); 
                if (page == null)
                {
                    code = 404;
                    response = new ErrorResponse("Paginated reservations by creator not found");
                }
                else
                {
                    response = new ItemResponse<Paged<Reservation>> { Item = page };
                }
            }
            catch (Exception ex)
            {
                code = 500;
                response = new ErrorResponse(ex.Message);
                base.Logger.LogError(ex.ToString());
            }
            return StatusCode(code, response);
        }

        [HttpPut("{id:int}")] 
        public ActionResult<SuccessResponse> Update(ReservationUpdateRequest model)
        {
            int code = 200;
            BaseResponse response = null;
            int userId = _authService.GetCurrentUserId();
            try
            {
                _service.Update(model, userId);
                response = new SuccessResponse();
            }
            catch (Exception ex)
            {
                code = 500;
                response = new ErrorResponse(ex.Message);
            }
            return StatusCode(code, response);
        }

        [HttpPut("product")] 
        public ActionResult<SuccessResponse> UpdateStatusByProductId(int productId, int statusId)
        {
            int code = 200;
            BaseResponse response = null;
            
            try
            {
                _service.UpdateStatusByProductId(productId, statusId);
                response = new SuccessResponse(); 
            }
            catch (Exception ex)
            {
                code = 500;
                response = new ErrorResponse(ex.Message);
            }
            return StatusCode(code, response);
        }
    }
}
