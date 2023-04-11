﻿using Makai.Models.Requests.Reservations;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Makai.Models.Requests
{
    public class ReservationUpdateRequest : ReservationAddRequest, IModelIdentifier
    {
        [Required]
        public int Id { get; set; }
    }
}
