﻿using AutoMapper;
using RelearnAngularApi.Inputs;
using RelearnAngularApi.Models;

namespace RelearnAngularApi.MappingProfiles
{
    public class CharacterMappingProfile : Profile
    {
        public CharacterMappingProfile() { 

            CreateMap<CreateCharacterInput, Character>()
                .ForMember(dest => dest.Name, opt => opt.MapFrom(src => src.Name))
                .ForMember(dest => dest.Id, opt => opt.Ignore()); 
        
        }
    }
}
