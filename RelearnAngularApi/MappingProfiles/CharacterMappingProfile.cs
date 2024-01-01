using AutoMapper;
using RelearnAngularApi.Inputs;
using RelearnAngularApi.Models;

namespace RelearnAngularApi.MappingProfiles
{
    public class CharacterMappingProfile : Profile
    {
        public CharacterMappingProfile() { 

            CreateMap<CreateCharacterInput, Character>()
                .ForMember(dest => dest.Name, opt => opt.MapFrom(src => src.Name))
                .ForMember(dest => dest.Species, opt => opt.MapFrom(src => src.Species))
                .ForMember(dest => dest.Origin, opt => opt.MapFrom(src => src.Origin))
                .ForMember(dest => dest.LifeStatus, opt => opt.MapFrom(src => src.LifeStatus))
                .ForMember(dest => dest.Id, opt => opt.Ignore()); 
        
        }
    }
}
