using Makai.Models.Domain.Reservations;
using Makai.Models;
using Makai.Models.Requests.Reservations;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Makai.Models.Requests;

namespace Makai.Services.Interfaces
{
    public interface IReservationService
    {
        int Add(ReservationAddRequest model, int userId);
        Paged<Reservation> GetPaginated(int pageIndex, int pageSize);
        Reservation GetById(int id);
        Paged<Reservation> GetByCreatedBy(int pageIndex, int pageSize, int creator);
        void Update(ReservationUpdateRequest model, int userId);
        void UpdateStatusByProductId(int productId, int statusId);
    }
}
